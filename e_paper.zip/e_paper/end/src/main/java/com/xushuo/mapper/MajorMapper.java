package com.xushuo.mapper;

import com.xushuo.entity.Major;
import com.xushuo.util.MyMapper;
import java.util.Map;
import java.util.List;

/**
 * 操作majorDAO层接口
*/
public interface MajorMapper extends MyMapper<Major> {

    /**
      * 分页查询数据
    */
    List<Major> queryAllByLimit(Map mp);

    /**
      * 通过实体作为筛选条件查询
    */
    List<Major> queryCondition(Major major);

    /**
      * 通过ID查询单条数据
    */
    Major queryById(Integer id);

    /**
      * 新增
    */
    int insert(Major major);

    /**
      * 修改
    */
    boolean update(Major major);

    /**
      * 删除
    */
    int deleteById(Integer id);

}