package com.xushuo.service;

import com.xushuo.entity.Classes;
import com.xushuo.mapper.ClassesMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.*;
/**
 * 班级表业务处理
 **/
@Service
public class ClassesService {

    @Autowired
    private ClassesMapper classesMapper;

    /**
     * 分页查询
     */
    public List<Classes> queryAllByLimit(Map mp) {
        return classesMapper.queryAllByLimit(mp);
    }

    /**
     * 查询所有
     */
    public List<Classes> queryCondition(Classes classes) {
        return classesMapper.queryCondition(classes);
    }

    /**
     * 通过ID查询单条数据
     */
    public Classes queryById(Integer id) {
        return classesMapper.queryById(id);
    }

    /**
     * 新增
     */
    public int insert(Classes classes) {
        return classesMapper.insert(classes);
    }

    /**
     * 修改
     */
    public boolean update(Classes classes) {
        return classesMapper.update(classes);
    }

    /**
     * 删除
     */
    public boolean deleteById(Integer id) {
        return classesMapper.deleteById(id) > 0;
    }

}