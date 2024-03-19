package com.mycompany.spring_mvc_project_final.repository;

import com.mycompany.spring_mvc_project_final.entities.Movie;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MovieRepository extends CrudRepository<Movie, Long> {
    Movie findByMovieId(Long movieId);
    List<Movie> findByMovieName(String movieName);
    List<Movie> findByDirector(String director);
    List<Movie> findByProducer(String producer);
    List<Movie> findByActor(String actor);

    List<Movie> findByMovieNameOrDirectorOrProducerOrActor(String movieName, String director, String producer, String actor);

}