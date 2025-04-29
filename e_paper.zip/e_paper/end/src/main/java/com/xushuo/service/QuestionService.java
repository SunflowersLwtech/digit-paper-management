package com.xushuo.service;

import com.xushuo.entity.Question;
import com.xushuo.mapper.QuestionMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.*;
/**
 * 题目表业务处理
 **/
@Service
public class QuestionService {

    @Autowired
    private QuestionMapper questionMapper;

    /**
     * 分页查询
     */
    public List<Question> queryAllByLimit(Map mp) {
        return questionMapper.queryAllByLimit(mp);
    }

    /**
     * 查询所有
     */
    public List<Question> queryCondition(Question question) {
        return questionMapper.queryCondition(question);
    }

    /**
     * 通过ID查询单条数据
     */
    public Question queryById(Integer id) {
        return questionMapper.queryById(id);
    }

    /**
     * 新增
     */
    public int insert(Question question) {
        return questionMapper.insert(question);
    }

    /**
     * 修改
     */
    public boolean update(Question question) {
        return questionMapper.update(question);
    }

    /**
     * 删除
     */
    public boolean deleteById(Integer id) {
        return questionMapper.deleteById(id) > 0;
    }

}