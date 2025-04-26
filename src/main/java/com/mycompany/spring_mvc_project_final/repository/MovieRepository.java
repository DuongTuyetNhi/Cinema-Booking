package com.mycompany.spring_mvc_project_final.repository;

import com.mycompany.spring_mvc_project_final.entities.Movie;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import javax.transaction.Transactional;
import java.sql.Date;
import java.util.List;

@Repository
@Transactional
public interface MovieRepository extends CrudRepository<Movie, Long> {
    Movie findByMovieId(Long movieId);
    List<Movie> findByMovieNameLike(String movieName);
    List<Movie> findByDirectorLike(String director);
    List<Movie> findByProducerLike(String producer);
    List<Movie> findByActorLike(String actor);
    List<Movie> findByMovieNameOrDirectorOrProducerOrActor(String movieName, String director, String producer, String actor);
    List<Movie> findAll();
    @Query(value = "SELECT DISTINCT m.movieId, m.actor, m.describeMovie, m.movieName, m.nation, m.photo, m.producer, m.timeSlot, m.trailer, m.cateId, m.director FROM movie m\n" +
            "join movieshowtime m1 on m.movieId = m1.movieId\n" +
            "join showtime s1 on m1.showTimeId= s1.showTimeId\n" +
            "join roomshowtime r1 on s1.showTimeId=r1.showTimeId\n" +
            "where s1.showDate = ?1",nativeQuery = true)
    List<Movie> findMovie(String showDate);

    @Query("SELECT m FROM Movie m WHERE " +
            "LOWER(m.movieName) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
            "LOWER(m.director) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
            "LOWER(m.producer) LIKE LOWER(CONCAT('%', :keyword, '%')) OR " +
            "LOWER(m.actor) LIKE LOWER(CONCAT('%', :keyword, '%'))")
    List<Movie> searchByKeyword(@Param("keyword") String keyword);

}