package com.xushuo.mapper;

import com.xushuo.entity.Question;
import com.xushuo.util.MyMapper;
import org.apache.ibatis.annotations.Param;

import java.util.Map;
import java.util.List;

/**
 * 操作questionDAO层接口
*/
public interface QuestionMapper extends MyMapper<Question> {

    /**
      * 分页查询数据
    */
    List<Question> queryAllByLimit(Map mp);

    /**
      * 通过实体作为筛选条件查询
    */
    List<Question> queryCondition(Question question);

    /**
      * 通过ID查询单条数据
    */
    Question queryById(Integer id);

    /**
      * 新增
    */
    int insert(Question question);

    /**
      * 修改
    */
    boolean update(Question question);

    /**
      * 删除
    */
    int deleteById(Integer id);

    List<Question> getRandomQuestions(@Param("courseId") Integer courseId,
                                      @Param("type") String type,
                                      @Param("count") Integer count);
    int getCountByCidAndType(@Param("courseId") Integer courseId,
                                      @Param("type") String type);
}