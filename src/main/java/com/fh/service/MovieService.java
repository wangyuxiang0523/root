package com.fh.service;

import com.fh.model.Movie;
import com.fh.model.PageBean;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MovieService {

    PageBean<Movie> queryPageList(PageBean<Movie> pageBean,  Movie movie);

    Movie queryMovieById(Integer id);

    void addMovie(Movie movie);

    void updateMovie(Movie movie);


}
