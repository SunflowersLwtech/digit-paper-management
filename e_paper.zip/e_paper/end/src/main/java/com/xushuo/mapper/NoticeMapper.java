package com.xushuo.mapper;

import com.xushuo.entity.Notice;
import com.xushuo.util.MyMapper;
import java.util.Map;
import java.util.List;

/**
 * 操作noticeDAO层接口
*/
public interface NoticeMapper extends MyMapper<Notice> {

    /**
      * 分页查询数据
    */
    List<Notice> queryAllByLimit(Map mp);

    /**
      * 通过实体作为筛选条件查询
    */
    List<Notice> queryCondition(Notice notice);

    /**
      * 通过ID查询单条数据
    */
    Notice queryById(Integer id);

    /**
      * 新增
    */
    int insert(Notice notice);

    /**
      * 修改
    */
    boolean update(Notice notice);

    /**
      * 删除
    */
    int deleteById(Integer id);

}