import React from 'react'
import { useState, useEffect } from "react";
import Modal from 'react-bootstrap/Modal';
import Button from 'react-bootstrap/Button';

const Homepage = (props) => {

    //User login jooks
    const [isLoggedIn, setIsLoggedIn] = useState(props.signed_in);
    const [userInfo, setUserInfo] = useState(props.user_info)

    //Modal show hooks
    const [showCreateRoomModal, setShowCreateRoomModal] = useState(false);
    const [showJoinRoomModal, setShowJoinRoomModal] = useState(false);
    const [showAddRestaurantModal, setShowAddRestaurantModal] = useState(false);

    //Modal field value hooks
    const [loginModalFields, setLoginModalFields] = useState({
        name: ""
    });
    const [createRoomFields, setCreateRoomFields] = useState({
        name: "",
        location: (props.locations.length > 0) ? props.locations[0]["id"] : "",
        token: "",
    });
    const [joinRoomFields, setJoinRoomFields] = useState({
        name: "",
        token: "",
    });
    const [addRestaurantFields, setAddRestaurantFields] = useState({
        name: "",
        description: "",
        location: props.locations[0]["id"],
    });

    //Functions for showing/closing the modal
    const handleCreateRoomClose = () => setShowCreateRoomModal(false);
    const handleCreateRoomShow = () => setShowCreateRoomModal(true);
    const handleJoinRoomClose = () => setShowJoinRoomModal(false);
    const handleJoinRoomShow = () => setShowJoinRoomModal(true);
    const handleAddRestaurantClose = () => setShowAddRestaurantModal(false);
    const handleAddRestaurantShow = () => setShowAddRestaurantModal(true);

    //Get location info from db
    let locations = props.locations;
    let optionItems = locations.map((location) =>
            <option  value={location.id} key={location.name}>{location.name}</option>
        );

    //Sign in as guest
    const signInAsGuest = () => {
        console.log(props.session);

        fetch('/guest_signin', {
            method: 'POST', 
            headers: {
                'Content-Type': 'application/json'
            }, 
            body: JSON.stringify({
                name: loginModalFields["name"]
            })
        })
        .then(response => response.json())
        .then(data => {
            console.log(data);
            if (data['status'] == 200) {
                let user_data = data['user_data'];
                setUserInfo({...userInfo, name: user_data['name']});
                setIsLoggedIn(true);
            } else {
                console.log("Status: " + data['status']);
            }
        })
        .catch((error) => {
            console.error("Error: ", error);
        });
    }

    //Update Location fields 
    function updateRoomLocation(e){
        setCreateRoomFields({...createRoomFields, location: parseInt(e.target.value)})
    }
    function updateRestaurantLocation(e){
        setAddRestaurantFields({...addRestaurantFields, location: parseInt(e.target.value)})
    }

    //Join room request
    const joinRoomRequest=() => {
        console.log ("you are joined with token ", )
        fetch('/room/join', {
            method: 'POST', 
            redirect: 'follow',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                token: joinRoomFields["token"],
            })
        })
        .then(response => {
            if (response.redirected) {
                window.location.href = response.url;
            }
        })
    }

    //Create Room Request
    const createRoomRequest=() => {
        fetch('/room', {
            method: 'POST', 
            headers: {
                'Content-Type': 'application/json'
            }, 
            body: JSON.stringify({
                room_name: createRoomFields["name"],
                location_id: createRoomFields["location"]
            })
        })
        .then(response => response.json())
        .then(data => {
            console.log(data);
            if (data['status'] == 200) {
                console.log("OK")
                setCreateRoomFields({...createRoomFields, token: data['room_token']})
            } else {
                console.log("Status: " + data['status']);
            }
        })
        .catch((error) => {
            console.error("Error: ", error);
        });
    }

    //Add Restaurant Request
    const AddRestaurantRequest=() => {
        fetch('/restaurant', {
            method: 'POST', 
            headers: {
                'Content-Type': 'application/json'
            }, 
            body: JSON.stringify({
                name: addRestaurantFields["name"],
                description: addRestaurantFields["description"],
                location_id:addRestaurantFields["location"]
            })
        })
        .then(response => response.json())
        .then(data => {
            console.log(data);
            if (data['status'] == 200) {
                console.log("OK created restaurant")
            } else {
                console.log("Status: " + data['status']);
            }
        })
        .catch((error) => {
            console.error("Error: ", error);
        });
    }

    return (
        <div className="container">
            <div>Welcome to our app {userInfo["name"]}</div>
            <button type="button" className="btn btn-primary" onClick={handleJoinRoomShow}>Join room</button>
            <button type="button" className="btn btn-primary" onClick={handleCreateRoomShow}>Create Room</button>
            <button type="button" className="btn btn-primary" onClick={handleAddRestaurantShow}>Add Restaurant</button>

            <Modal show={!isLoggedIn}>
                <Modal.Header closeButton>
                    <Modal.Title>Sign-in to Proceed</Modal.Title>
                </Modal.Header>

                <div className="input-group input-group-sm mb-3">
                    <div className="input-group-prepend">
                        <span className="input-group-text" id="inputGroup-sizing-sm">Name</span>
                    </div>
                    <input type="text" className="form-control" aria-label="Small" aria-describedby="inputGroup-sizing-sm" onChange={e => setLoginModalFields({...loginModalFields, name: e.target.value})} value={loginModalFields['name']}/>
                </div>
            
                <Modal.Footer>
                    <Button variant="primary" onClick={signInAsGuest}>
                    Sign In as a Guest
                    </Button>
                </Modal.Footer>
            </Modal>


            <Modal show={showJoinRoomModal} onHide={handleJoinRoomClose}>
                <Modal.Header closeButton>
                    <Modal.Title>Join Room</Modal.Title>
                </Modal.Header>
                <Modal.Body>Fill out this info so we can assign you to the correct room</Modal.Body>

                <div className="input-group input-group-sm mb-3">
                    <div className="input-group-prepend">
                        <span className="input-group-text" id="inputGroup-sizing-sm">Name</span>
                    </div>
                    <input type="text" className="form-control" aria-label="Small" aria-describedby="inputGroup-sizing-sm" onChange={e => setJoinRoomFields({...joinRoomFields, name: e.target.value})} value={joinRoomFields['name']}/>
                </div>
                <div className="input-group input-group-sm mb-3">
                    <div className="input-group-prepend">
                        <span className="input-group-text" id="inputGroup-sizing-sm">Room Token</span>
                    </div>
                    <input type="text" className="form-control" aria-label="Small" aria-describedby="inputGroup-sizing-sm" onChange={e => setJoinRoomFields({...joinRoomFields, token: e.target.value})} value={joinRoomFields['token']}/>
                </div>

                <Modal.Footer>
                    <Button variant="secondary" onClick={handleJoinRoomClose}>
                        Close
                    </Button>
                    <Button variant="primary" onClick={joinRoomRequest}>
                    Join the Room!
                    </Button>
                </Modal.Footer>
            </Modal>

            <Modal show={showCreateRoomModal} onHide={handleCreateRoomClose}>
                <Modal.Header closeButton>
                    <Modal.Title>Create Room</Modal.Title>
                </Modal.Header>
                <Modal.Body>Create your own room!</Modal.Body>

                <div className="input-group input-group-sm mb-3">
                    <div className="input-group-prepend">
                        <span className="input-group-text" id="inputGroup-sizing-sm">Name</span>
                    </div>
                    <input type="text" className="form-control" aria-label="Small" aria-describedby="inputGroup-sizing-sm" onChange={e => setCreateRoomFields({...createRoomFields, name: e.target.value})} value={createRoomFields['name']}/>
                </div>
                <div className="input-group input-group-sm mb-3">
                    <div className="input-group-prepend">
                        <span className="input-group-text" id="inputGroup-sizing-sm">Location</span>
                    </div>
                    <div>
                            <select value={createRoomFields["location"]} onChange={updateRoomLocation} >
                                {optionItems}
                            </select>
                    </div>
                </div>
                <div className="input-group input-group-sm mb-3">
                    <div className="input-group-prepend">
                        <span className="input-group-text" id="inputGroup-sizing-sm">Room Token</span>
                    </div>
                    
                    <input type="text" className="form-control" aria-label="Small" aria-describedby="inputGroup-sizing-sm"  value={createRoomFields['token']}/>
                </div>

                <Modal.Footer>
                    <Button variant="secondary" onClick={handleCreateRoomClose}>
                        Close
                    </Button>
                    <Button variant="primary" onClick={createRoomRequest}>
                    Create the Room!
                    </Button>
                </Modal.Footer>
            </Modal>

            <Modal show={showAddRestaurantModal} onHide={handleAddRestaurantClose}>
                <Modal.Header closeButton>
                    <Modal.Title>Add Restaurant</Modal.Title>
                </Modal.Header>
                <Modal.Body>Add a Restaurant :)</Modal.Body>

                <div className="input-group input-group-sm mb-3">
                    <div className="input-group-prepend">
                        <span className="input-group-text" id="inputGroup-sizing-sm">Name</span>
                    </div>
                    <input type="text" className="form-control" aria-label="Small" aria-describedby="inputGroup-sizing-sm" onChange={e => setAddRestaurantFields({...addRestaurantFields, name: e.target.value})} value={addRestaurantFields['name']}/>
                </div>
                <div className="input-group input-group-sm mb-3">
                    <div className="input-group-prepend">
                        <span className="input-group-text" id="inputGroup-sizing-sm">Decription</span>
                    </div>
                    <textarea type="text" className="form-control" rows = "3" aria-label="Small" aria-describedby="inputGroup-sizing-sm" onChange={e => setAddRestaurantFields({...addRestaurantFields, description: e.target.value})} value={addRestaurantFields['desciption']}/>
                </div>
                <div className="input-group input-group-sm mb-3">
                    <div className="input-group-prepend">
                        <span className="input-group-text" id="inputGroup-sizing-sm">Location</span>
                    </div>
                    <div>
                            <select value={addRestaurantFields["location"]} onChange={updateRestaurantLocation} >
                                {optionItems}
                            </select>
                    </div>
                </div>
                <Modal.Footer>
                    <Button variant="secondary" onClick={handleAddRestaurantClose}>
                        Close
                    </Button>
                    <Button variant="primary" onClick={AddRestaurantRequest}>
                        Add
                    </Button>
                </Modal.Footer>
            </Modal>
        </div>
    );
}

export default Homepage 