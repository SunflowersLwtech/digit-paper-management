package com.xushuo.service;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.PdfWriter;
import com.itextpdf.text.pdf.draw.LineSeparator;
import com.xushuo.entity.Exams;
import com.xushuo.entity.Question;
import com.xushuo.mapper.ExamsMapper;
import com.xushuo.mapper.QuestionMapper;
import com.xushuo.util.PdfFontUtil;
import com.xushuo.util.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.*;
import java.util.List;

@Service
public class ExamsService {

    @Value("${uploadDir}")
    private String uploadPath;

    @Autowired
    private ExamsMapper examsMapper;

    @Autowired
    private QuestionMapper questionMapper;

    /**
     * 分页查询
     */
    public List<Exams> queryAllByLimit(Map mp) {
        return examsMapper.queryAllByLimit(mp);
    }

    /**
     * 查询所有
     */
    public List<Exams> queryCondition(Exams exams) {
        return examsMapper.queryCondition(exams);
    }

    /**
     * 通过ID查询单条数据
     */
    public Exams queryById(Integer id) {
        return examsMapper.queryById(id);
    }

    /**
     * 新增
     */
    public int insert(Exams exams) {
        return examsMapper.insert(exams);
    }

    /**
     * 修改
     */
    public boolean update(Exams exams) {
        return examsMapper.update(exams);
    }

    /**
     * 删除
     */
    public boolean deleteById(Integer id) {
        return examsMapper.deleteById(id) > 0;
    }

    @Transactional
    public Result generateExam(Map<String, Object> params) {
        try {
            // 1. 获取题目配置
            int choiceCount = Integer.parseInt(params.get("choiceCount").toString());
            int fillCount = Integer.parseInt(params.get("fillCount").toString());
            int essayCount = Integer.parseInt(params.get("essayCount").toString());
            BigDecimal choiceScore = new BigDecimal(params.get("choiceScore").toString());
            BigDecimal fillScore = new BigDecimal(params.get("fillScore").toString());
            BigDecimal essayScore = new BigDecimal(params.get("essayScore").toString());

            Integer courseId = Integer.parseInt(params.get("cid").toString());

            int choiceCount1 = questionMapper.getCountByCidAndType(courseId, "01");
            int fillCount1 = questionMapper.getCountByCidAndType(courseId, "02");
            int essayCount1 = questionMapper.getCountByCidAndType(courseId, "03");
            if(choiceCount1<choiceCount){
                return Result.error("选择题题库共"+choiceCount1+"个，还需要"+(choiceCount-choiceCount1)+"个，请添加题库");
            }
            if(fillCount1<fillCount){
                return Result.error("填空题题库共"+fillCount1+"个，还需要"+(fillCount-fillCount1)+"个，请添加题库");
            }
            if(essayCount1<essayCount){
                return Result.error("简答题题库共"+essayCount1+"个，还需要"+(essayCount-essayCount1)+"个，请添加题库");
            }

            // 2. 随机获取题目
            List<Question> choiceQuestions = questionMapper.getRandomQuestions(courseId, "01", choiceCount);
            List<Question> fillQuestions = questionMapper.getRandomQuestions(courseId, "02", fillCount);
            List<Question> essayQuestions = questionMapper.getRandomQuestions(courseId, "03", essayCount);

            // 3. 生成PDF文件
            String pdfPath = generatePDF(params.get("title").toString(), 
                choiceQuestions, fillQuestions, essayQuestions,
                choiceScore, fillScore, essayScore);

            // 4. 保存试卷信息
            Exams exam = new Exams();
            exam.setTitle(params.get("title").toString());
            exam.setCid(courseId);
            exam.setType("01"); // 自动生成
            exam.setFilePath(pdfPath);
            exam.setFileType("pdf");
            exam.setStatus("01");
            exam.setCcid(params.get("ccid").toString());
            exam.setCreateTime(new Date());
            examsMapper.insert(exam);



            return Result.success("试卷生成成功");
        } catch (Exception e) {
            throw new RuntimeException("生成试卷失败：" + e.getMessage());
        }
    }

    private String generatePDF(String title, List<Question> choiceQuestions,
                             List<Question> fillQuestions, List<Question> essayQuestions,
                             BigDecimal choiceScore, BigDecimal fillScore, BigDecimal essayScore) throws Exception {
        String fileName = UUID.randomUUID().toString() + ".pdf";
        String filePath = uploadPath + "/" + fileName;

        Document document = new Document(PageSize.A4, 50, 50, 50, 50);
        PdfWriter.getInstance(document, new FileOutputStream(filePath));
        document.open();

        // 添加试卷标题
        Font titleFont = PdfFontUtil.getChineseBoldFont(20);
        Paragraph titlePara = new Paragraph(title, titleFont);
        titlePara.setAlignment(Element.ALIGN_CENTER);
        titlePara.setSpacingAfter(20f);
        document.add(titlePara);

        // 添加考试信息
        Font infoFont = PdfFontUtil.getChineseFont(12);
        Paragraph infoPara = new Paragraph();
        infoPara.setFont(infoFont);
        infoPara.add("院系：____________    班级：____________    姓名：____________    学号：____________\n");
        infoPara.setSpacingAfter(20f);
        document.add(infoPara);
        // 添加分隔线
        LineSeparator line = new LineSeparator();
        line.setLineWidth(0.5f);
        document.add(new Chunk(line));
        document.add(new Paragraph("\n"));

        // 添加选择题
        if (!choiceQuestions.isEmpty()) {
            Font sectionFont = PdfFontUtil.getChineseBoldFont(14);
            Paragraph section1 = new Paragraph("一、选择题（每题" + choiceScore + "分，共" +
                (choiceQuestions.size() * choiceScore.intValue()) + "分）", sectionFont);
            section1.setSpacingAfter(10f);
            document.add(section1);

            Font questionFont = PdfFontUtil.getChineseFont(12);
            for (int i = 0; i < choiceQuestions.size(); i++) {
                Question q = choiceQuestions.get(i);
                Paragraph questionPara = new Paragraph((i + 1) + ". " + q.getContent(), questionFont);
                questionPara.setFirstLineIndent(20f);
                questionPara.setSpacingBefore(10f);
                document.add(questionPara);

                // 添加选项
                Map<String, String> options = parseOptions(q.getOptions());
                for (Map.Entry<String, String> entry : options.entrySet()) {
                    Paragraph optionPara = new Paragraph(entry.getKey() + ". " + entry.getValue(), questionFont);
                    optionPara.setFirstLineIndent(40f);
                    document.add(optionPara);
                }
            }
            document.add(new Paragraph("\n"));
        }

        // 添加填空题
        if (!fillQuestions.isEmpty()) {
            Font sectionFont = PdfFontUtil.getChineseBoldFont(14);
            Paragraph section2 = new Paragraph("二、填空题（每题" + fillScore + "分，共" +
                (fillQuestions.size() * fillScore.intValue()) + "分）", sectionFont);
            section2.setSpacingAfter(10f);
            document.add(section2);

            Font questionFont = PdfFontUtil.getChineseFont(12);
            for (int i = 0; i < fillQuestions.size(); i++) {
                Question q = fillQuestions.get(i);
                Paragraph questionPara = new Paragraph((i + 1) + ". " + q.getContent(), questionFont);
                questionPara.setFirstLineIndent(20f);
                questionPara.setSpacingBefore(10f);
                questionPara.setSpacingAfter(20f);
                document.add(questionPara);
            }
            document.add(new Paragraph("\n"));
        }

        // 添加简答题
        if (!essayQuestions.isEmpty()) {
            Font sectionFont = PdfFontUtil.getChineseBoldFont(14);
            Paragraph section3 = new Paragraph("三、简答题（每题" + essayScore + "分，共" +
                (essayQuestions.size() * essayScore.intValue()) + "分）", sectionFont);
            section3.setSpacingAfter(10f);
            document.add(section3);

            Font questionFont = PdfFontUtil.getChineseFont(12);
            for (int i = 0; i < essayQuestions.size(); i++) {
                Question q = essayQuestions.get(i);
                Paragraph questionPara = new Paragraph((i + 1) + ". " + q.getContent(), questionFont);
                questionPara.setFirstLineIndent(20f);
                questionPara.setSpacingBefore(10f);
                document.add(questionPara);

                // 添加答题空间
                Paragraph answerSpace = new Paragraph("\n\n\n");
                document.add(answerSpace);
            }
        }

        // 添加页脚
        Font footerFont = PdfFontUtil.getChineseFont(10);
        Paragraph footer = new Paragraph("本卷由电子试卷管理系统出", footerFont);
        footer.setAlignment(Element.ALIGN_CENTER);
        document.add(footer);
        document.close();
        return fileName;
    }
    public String uploadExamFile(MultipartFile file) {
        try {
            String originalFilename = file.getOriginalFilename();
            String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
            String fileName = UUID.randomUUID().toString() + extension;
            String filePath = uploadPath + "/" + fileName;
            
            File dest = new File(filePath);
            if (!dest.getParentFile().exists()) {
                dest.getParentFile().mkdirs();
            }
            file.transferTo(dest);
            
            return fileName;
        } catch (Exception e) {
            throw new RuntimeException("文件上传失败：" + e.getMessage());
        }
    }

    public void previewExam(Long id, HttpServletResponse response) {
        try {
            Exams exam = examsMapper.selectById(id);
            if (exam == null) {
                throw new RuntimeException("试卷不存在");
            }

            File file = new File(uploadPath + "/" + exam.getFilePath());
            if (!file.exists()) {
                throw new RuntimeException("文件不存在");
            }

            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "inline; filename=" + exam.getFilePath());
            
            try (InputStream is = new FileInputStream(file);
                 OutputStream os = response.getOutputStream()) {
                byte[] buffer = new byte[1024];
                int length;
                while ((length = is.read(buffer)) > 0) {
                    os.write(buffer, 0, length);
                }
                os.flush();
            }
        } catch (Exception e) {
            throw new RuntimeException("预览文件失败：" + e.getMessage());
        }
    }

    public void downloadExam(Long id, HttpServletResponse response) {
        try {
            Exams exam = examsMapper.selectById(id);
            if (exam == null) {
                throw new RuntimeException("试卷不存在");
            }

            //从路径中获取文件名带后缀
            String fileName = exam.getFilePath().substring(exam.getFilePath().lastIndexOf("/") + 1);
            File file = new File(uploadPath + "/" + fileName);
            if (!file.exists()) {
                throw new RuntimeException("文件不存在");
            }

            // 使用试卷标题作为文件名
            String fileNameInfo = URLEncoder.encode(exam.getTitle() + "."+exam.getFileType(), "UTF-8");
            response.setContentType("application/octet-stream");
            response.setHeader("Content-Disposition", "attachment; filename=\"" + fileNameInfo + "\"");
            
            try (InputStream is = new FileInputStream(file);
                 OutputStream os = response.getOutputStream()) {
                byte[] buffer = new byte[1024];
                int length;
                while ((length = is.read(buffer)) > 0) {
                    os.write(buffer, 0, length);
                }
                os.flush();
            }
        } catch (Exception e) {
            throw new RuntimeException("下载文件失败：" + e.getMessage());
        }
    }

    public Result getExamsList(Map<String, Object> params) {
        return Result.success(examsMapper.selectExamsList(params));
    }

    private Map<String, String> parseOptions(String optionsJson) {
        Map<String, String> options = new LinkedHashMap<>();
        try {
            if (optionsJson != null && !optionsJson.isEmpty()) {
                ObjectMapper mapper = new ObjectMapper();
                options = mapper.readValue(optionsJson, new TypeReference<Map<String, String>>() {});
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return options;
    }
}