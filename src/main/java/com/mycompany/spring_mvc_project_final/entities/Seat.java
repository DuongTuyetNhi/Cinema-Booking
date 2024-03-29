package com.mycompany.spring_mvc_project_final.entities;


import javax.persistence.*;


@Entity
@Table(name = "seat")
public class Seat {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long seatId;


    @Column
    private String seatName;


    @Column
    private String status;


    @ManyToOne
    @JoinColumn(name = "seatTypeId")
    private SeatType seatType;


    @ManyToOne
    @JoinColumn(name = "roomId")
    private Room room;


    @OneToOne(mappedBy = "seat")
    private Ticket ticket;


    public Long getSeatId() {
        return seatId;
    }


    public void setSeatId(Long seatId) {
        this.seatId = seatId;
    }


    public String getSeatName() {
        return seatName;
    }

    public void setSeatName(String seatName) {
        this.seatName = seatName;
    }

    public String getStatus() {
        return status;
    }


    public void setStatus(String status) {
        this.status = status;
    }


    public SeatType getSeatType() {
        return seatType;
    }


    public void setSeatType(SeatType seatType) {
        this.seatType = seatType;
    }


    public Room getRoom() {
        return room;
    }


    public void setRoom(Room room) {
        this.room = room;
    }


    public Ticket getTicket() {
        return ticket;
    }


    public void setTicket(Ticket ticket) {
        this.ticket = ticket;
    }
}
