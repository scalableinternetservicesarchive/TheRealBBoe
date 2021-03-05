import React from 'react'
import { useState, useEffect } from "react";
import { Form } from 'react-bootstrap';
import Modal from 'react-bootstrap/Modal';
import Button from 'react-bootstrap/Button';

const Roompage = (props) => {
    const [roomToken, setRoomToken] = useState(props.room_token)
    const [restaurants, setRestaurants] = useState(props.restaurants)
    const [selectedRestaurants, setSelectedRestaurants] = useState([]);
    const [doneVoting, setDoneVoting] = useState(props.voted);
    const [roomVotes, setRoomVotes] = useState(props.votes);
    const [roomParticipants, setRoomParticipants] = useState(props.participants)

    // Run Once at first render
    useEffect(() => {
    }, []);

    function buttonColor(value) {
        return selectedRestaurants.includes(value.toString()) ? "success" : "secondary";
    }

    function clickRestaurantButton(e) {
        let rid = e.target.value;
        console.log(rid);
        setSelectedRestaurants([...selectedRestaurants].includes(rid) ? [...selectedRestaurants].filter(selected_id => selected_id != rid) : [...selectedRestaurants].concat(rid));
    }

    function submitVotes(e) {
        let votes = [...selectedRestaurants];
        let votes_str = "";
        for (let i=0; i<votes.length; i++) {
            votes_str += votes[i].toString();
            if (i != votes.length-1) {
                votes_str += ";";
            }
        }

        fetch('/member/update_vote', {
            method: 'POST', 
            headers: {
                'Content-Type': 'application/json'
            }, 
            body: JSON.stringify({
                votes: votes_str, 
                token: roomToken
            })
        })
        .then(response => {
            if(response.ok) {
                return fetch('/room/votes/'+roomToken)
            } else {
                return Promise.reject(response);
            }
        })
        .then(response => response.json())
        .then(data => {
            console.log(data);
            setDoneVoting(true);
            var user_name = props.user_name
            setRoomParticipants({...roomParticipants, [user_name]: true})
            setRoomVotes(data["room_votes"]);
            console.log(roomVotes);
        })
        .catch((error) => {
            console.error("Error: ", error);
        });
    }

    const listParticipants = () => {
        console.log(roomParticipants)
        if (Object.keys(roomParticipants).length === 0) {
            var participantsList = <div>No Participants</div>
        }
        else {
            let memberIcons = [];
            for (let member in roomParticipants) {
                // If member voted alread
                if (roomParticipants[member]) {
                    memberIcons.push(<li style={{listStyleType: "none"}} >{member} voted</li>)
                }
                else {
                    memberIcons.push(<li style={{listStyleType: "none"}}>{member} has not voted</li>)
                }
            }

            return (<ul>{memberIcons}</ul>);
        }
    }

    ///asdfads
    const voteResults = () => {
        console.log(roomVotes);

        if (Object.keys(roomVotes).length === 0) {
            var votelist = <div>NO VOTES</div>
        } else {
            let votes = [];
            console.log(restaurants);
            for (let restaurant_id in roomVotes) {
                console.log(restaurant_id);
                votes.push([roomVotes[restaurant_id], restaurants[restaurant_id].name]);
            }

            votes.sort((a,b) => {
                return b[0] - a[0];
            })

            var voteList = votes.map((data) => {
                return(<li>{data[1]}:{data[0]}</li>)
            })  
        }


        return (<ul>{voteList}</ul>);
    }

    const optionItems = () => {
        var optionlist = [];
        for (let rid in restaurants) {
            let restaurant_name = restaurants[rid]["name"]
            let restaurant_description =restaurants[rid]["description"]
            optionlist.push( <div><Button 
                            id={"restaurant-"+rid} 
                            variant= {buttonColor(rid)}
                            value={rid} 
                            key={restaurant_name}
                            onClick={clickRestaurantButton}>
                        {restaurant_name} 
                        </Button>  {restaurant_description}  </div>);
        }

        return (<div>{optionlist}</div>)
    }

    return (
        <div class="container">

            { doneVoting 
              ? <div>
                    <div className = "participants">
                        <h4>Participants</h4>
                        {listParticipants()}
                    </div>

                    <h3>Results</h3>
                    {voteResults()}
                    <Button id="revote" onClick={e => setDoneVoting(false)}>Revote</Button>
                    
                </div>
              : <div>
                    <div className = "participants">
                        <h4>Participants</h4>
                        {listParticipants()}
                    </div>
                    {optionItems()}
                    <div><br/>
                        <Button id="submit-votes" onClick={submitVotes}>Submit</Button>
                    </div>
                </div>                
            }
        </div>
    );

}

export default Roompage 
