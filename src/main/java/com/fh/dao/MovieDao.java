package com.fh.dao;

import com.fh.model.Movie;
import com.fh.model.PageBean;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MovieDao {

    List<Movie>  queryPageList(@Param("pageBean") PageBean<Movie>pageBean,@Param("movie") Movie movie);

    Movie queryMovieById(Integer id);

    void addMovie(Movie movie);

    void updateMovie(Movie movie);

    Long queryCount(@Param("movie") Movie movie);
}
