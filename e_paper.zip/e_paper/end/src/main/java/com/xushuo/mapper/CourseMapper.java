package com.xushuo.mapper;

import com.xushuo.entity.Course;
import com.xushuo.util.MyMapper;
import java.util.Map;
import java.util.List;

/**
 * 操作courseDAO层接口
*/
public interface CourseMapper extends MyMapper<Course> {

    /**
      * 分页查询数据
    */
    List<Course> queryAllByLimit(Map mp);

    /**
      * 通过实体作为筛选条件查询
    */
    List<Course> queryCondition(Course course);

    /**
      * 通过ID查询单条数据
    */
    Course queryById(Integer id);

    /**
      * 新增
    */
    int insert(Course course);

    /**
      * 修改
    */
    boolean update(Course course);

    /**
      * 删除
    */
    int deleteById(Integer id);

}