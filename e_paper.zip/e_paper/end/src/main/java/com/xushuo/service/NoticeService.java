package com.xushuo.service;

import com.xushuo.entity.Notice;
import com.xushuo.mapper.NoticeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.*;
/**
 * 公告表业务处理
 **/
@Service
public class NoticeService {

    @Autowired
    private NoticeMapper noticeMapper;

    /**
     * 分页查询
     */
    public List<Notice> queryAllByLimit(Map mp) {
        return noticeMapper.queryAllByLimit(mp);
    }

    /**
     * 查询所有
     */
    public List<Notice> queryCondition(Notice notice) {
        return noticeMapper.queryCondition(notice);
    }

    /**
     * 通过ID查询单条数据
     */
    public Notice queryById(Integer id) {
        return noticeMapper.queryById(id);
    }

    /**
     * 新增
     */
    public int insert(Notice notice) {
        return noticeMapper.insert(notice);
    }

    /**
     * 修改
     */
    public boolean update(Notice notice) {
        return noticeMapper.update(notice);
    }

    /**
     * 删除
     */
    public boolean deleteById(Integer id) {
        return noticeMapper.deleteById(id) > 0;
    }

}