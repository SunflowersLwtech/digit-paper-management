package com.xushuo.service;

import com.xushuo.entity.Major;
import com.xushuo.mapper.MajorMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.*;
/**
 * 专业表业务处理
 **/
@Service
public class MajorService {

    @Autowired
    private MajorMapper majorMapper;

    /**
     * 分页查询
     */
    public List<Major> queryAllByLimit(Map mp) {
        return majorMapper.queryAllByLimit(mp);
    }

    /**
     * 查询所有
     */
    public List<Major> queryCondition(Major major) {
        return majorMapper.queryCondition(major);
    }

    /**
     * 通过ID查询单条数据
     */
    public Major queryById(Integer id) {
        return majorMapper.queryById(id);
    }

    /**
     * 新增
     */
    public int insert(Major major) {
        return majorMapper.insert(major);
    }

    /**
     * 修改
     */
    public boolean update(Major major) {
        return majorMapper.update(major);
    }

    /**
     * 删除
     */
    public boolean deleteById(Integer id) {
        return majorMapper.deleteById(id) > 0;
    }

}