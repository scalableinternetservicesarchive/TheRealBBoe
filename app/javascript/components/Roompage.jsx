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
    // Run Once at first render
    useEffect(() => {
    }, []);


    console.log(...restaurants);
    console.log(...selectedRestaurants);
    console.log(props.voted)

    const optionItems =  restaurants.map((r, index) => {
        return (<Button 
                    id={"restaurant-"+index} 
                    variant= {buttonColor(r.id)}
                    value={r.id} 
                    key={r.name}
                    onClick={clickRestaurantButton}>
                {r.name} 
                </Button>);
    });

    console.log(restaurants);
    console.log(selectedRestaurants);

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
        .then(response => response.json())
        .then(data => {
            console.log(data);
            setDoneVoting(true);
        })
        .catch((error) => {
            console.error("Error: ", error);
        });
    }

    return (

        <div class="container">
            <br/><br/>"Hello in the room"

            { doneVoting 
              ? <div>
                    <Button id="revote" onClick={e => setDoneVoting(false)}>Revote</Button>
                </div>
              : <div>
                    <div>
                        {optionItems}
                    </div>
                    <div>
                        <Button id="submit-votes" onClick={submitVotes}>Submit</Button>
                    </div>
                </div>                
            }
        </div>
    );

}

export default Roompage 
