package com.xushuo.mapper;

import com.xushuo.entity.Classes;
import com.xushuo.util.MyMapper;
import java.util.Map;
import java.util.List;

/**
 * 操作classesDAO层接口
*/
public interface ClassesMapper extends MyMapper<Classes> {

    /**
      * 分页查询数据
    */
    List<Classes> queryAllByLimit(Map mp);

    /**
      * 通过实体作为筛选条件查询
    */
    List<Classes> queryCondition(Classes classes);

    /**
      * 通过ID查询单条数据
    */
    Classes queryById(Integer id);

    /**
      * 新增
    */
    int insert(Classes classes);

    /**
      * 修改
    */
    boolean update(Classes classes);

    /**
      * 删除
    */
    int deleteById(Integer id);

}