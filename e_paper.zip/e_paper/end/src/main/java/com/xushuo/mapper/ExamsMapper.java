package com.xushuo.mapper;

import com.xushuo.entity.Exams;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;
import java.util.Map;

@Mapper
public interface ExamsMapper {
    /**
     * 分页查询数据
     */
    List<Exams> queryAllByLimit(Map mp);

    /**
     * 通过实体作为筛选条件查询
     */
    List<Exams> queryCondition(Exams exams);

    /**
     * 通过ID查询单条数据
     */
    Exams queryById(Integer id);

    /**
     * 新增
     */
    int insert(Exams exams);

    /**
     * 修改
     */
    boolean update(Exams exams);

    /**
     * 删除
     */
    int deleteById(Integer id);

    Exams selectById(Long id);
    List<Map<String, Object>> selectExamsList(Map<String, Object> params);
}