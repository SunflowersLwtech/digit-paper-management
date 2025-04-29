package com.xushuo.service;

import com.xushuo.entity.Course;
import com.xushuo.mapper.CourseMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.*;
/**
 * 课程表业务处理
 **/
@Service
public class CourseService {

    @Autowired
    private CourseMapper courseMapper;

    /**
     * 分页查询
     */
    public List<Course> queryAllByLimit(Map mp) {
        return courseMapper.queryAllByLimit(mp);
    }

    /**
     * 查询所有
     */
    public List<Course> queryCondition(Course course) {
        return courseMapper.queryCondition(course);
    }

    /**
     * 通过ID查询单条数据
     */
    public Course queryById(Integer id) {
        return courseMapper.queryById(id);
    }

    /**
     * 新增
     */
    public int insert(Course course) {
        return courseMapper.insert(course);
    }

    /**
     * 修改
     */
    public boolean update(Course course) {
        return courseMapper.update(course);
    }

    /**
     * 删除
     */
    public boolean deleteById(Integer id) {
        return courseMapper.deleteById(id) > 0;
    }

}