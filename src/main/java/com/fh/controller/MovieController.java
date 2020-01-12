package com.fh.controller;


import com.fh.model.Movie;
import com.fh.model.PageBean;
import com.fh.service.MovieService;
import com.fh.utils.CopyFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.Map;

@Controller
public class MovieController {
    @Autowired
    private MovieService movieService;


    @RequestMapping("toMovieList")
    public String toMovieList(){
        return "MovieList";
    }

    @RequestMapping("movieList")
    @ResponseBody
    public PageBean<Movie> queryUser(PageBean<Movie> pageBean, Movie movie) {
        movieService.queryPageList(pageBean,movie);
        return pageBean;
    }

    @RequestMapping("addMovie")
    @ResponseBody
    public Map<String,Object> addMovie(Movie movie){
        Map<String,Object>map=new HashMap<String, Object>();
        movieService.addMovie(movie);
        map.put("data",false);
        map.put("message","添加完成");
        return map;
    }

    @RequestMapping("uploadFile")
    @ResponseBody
    public  Map<String,Object> uploadFile(@RequestParam("photo") CommonsMultipartFile photo){
        Map<String,Object> map=new HashMap<String, Object>();
        String url=CopyFile.copyFile(photo,"photo");
        map.put("data",url);
        return map;
    }

    @RequestMapping("getMovieById")
    public ModelAndView getUserById(Integer id){
        ModelAndView mav=new ModelAndView("movieTable");
        Movie movie=movieService.queryMovieById(id);
        mav.addObject("movie",movie);
        return  mav;
    }
    @RequestMapping("updateMovie")
    @ResponseBody
    public void updateMovie(Movie movie){
        movieService.updateMovie(movie);
    }
}
