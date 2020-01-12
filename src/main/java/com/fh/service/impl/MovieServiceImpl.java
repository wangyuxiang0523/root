package com.fh.service.impl;

import com.fh.dao.MovieDao;
import com.fh.model.Movie;
import com.fh.model.PageBean;
import com.fh.service.MovieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class MovieServiceImpl  implements MovieService {
    @Autowired
    private MovieDao movieDao;
    public PageBean<Movie> queryPageList(PageBean<Movie> pageBean, Movie movie) {
         Long total= movieDao.queryCount(movie);
         pageBean.setRecordsFiltered(total);
         pageBean.setRecordsTotal(total);
         List<Movie>list= movieDao.queryPageList(pageBean,movie);
         pageBean.setData(list);
        return pageBean;
    }

    public Movie queryMovieById(Integer id) {
        return movieDao.queryMovieById(id);
    }

    public void addMovie(Movie movie) {
       movieDao.addMovie(movie);
    }

    public void updateMovie(Movie movie) {
        movieDao.updateMovie(movie);
    }
}
