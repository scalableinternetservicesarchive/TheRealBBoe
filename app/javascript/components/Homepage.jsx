import React from 'react'
import { useState, useEffect } from "react";
import Modal from 'react-bootstrap/Modal';
import Button from 'react-bootstrap/Button';

const Homepage = (props) => {

    //User login jooks
    const [isLoggedIn, setIsLoggedIn] = useState(props.signed_in);
    const [userInfo, setUserInfo] = useState(props.user_info);


    //Guest User
    const [isGuestUser, setIsGuestUser] =useState(false);
    const [isInUserTable, setIsInUserTable] =useState(false);

    //Modal show hooks
    const [showCreateRoomModal, setShowCreateRoomModal] = useState(false);
    const [showJoinRoomModal, setShowJoinRoomModal] = useState(false);
    const [showAddRestaurantModal, setShowAddRestaurantModal] = useState(false);
    const [showSignUpModal, setshowSignUpModal] = useState(false);

    //Modal field value hooks
    const [loginModalFields, setLoginModalFields] = useState({
        name: "",
        password: "",
    });
    const [guestNameField, setGuestNameFields] = useState({
        name: "",
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
        location: (props.locations.length > 0) ? props.locations[0]["id"] : "",
    });
    const [signUpFields, setSignUpFields] = useState({
        name: "",
        password: "",
        confirm_password: "",
        type_of_user: "regular",
    });

    //Functions for showing/closing the modal
    const handleCreateRoomClose = () => setShowCreateRoomModal(false);
    const handleCreateRoomShow = () => setShowCreateRoomModal(true);
    const handleJoinRoomClose = () => setShowJoinRoomModal(false);
    const handleJoinRoomShow = () => {
        setShowJoinRoomModal(true);
    }
    const handleAddRestaurantClose = () => setShowAddRestaurantModal(false);
    const handleAddRestaurantShow = () => setShowAddRestaurantModal(true);
    const handleSignUpClose = () => setshowSignUpModal(false);

    //Get location info from db
    let locations = props.locations;
    let optionItems = locations.map((location) =>
            <option  value={location.id} key={location.name}>{location.name}</option>
        );

    //continue as guest button click
    const continueAsGuest = () => {
        console.log(isGuestUser);
        console.log(isGuestUser);
        setIsGuestUser(true);
        //isGuestUser = true;
        setIsLoggedIn(true);
        
        console.log("in continue as guest");
        console.log(isGuestUser);
        console.log(isGuestUser);
    }

    //Sign in as guest
    const signInAsGuest = () => {
        console.log(props.session);

        fetch('/guest_signin', {
            method: 'POST', 
            headers: {
                'Content-Type': 'application/json'
            }, 
            body: JSON.stringify({
                name: guestNameField["name"]
            })
        })
        .then(response => response.json())
        .then(data => {
            console.log(data);
            if (data['status'] == 200) {
                console.log("Status: " + data['status']);
                let user_data = data['user_data'];
                //setUserInfo({...userInfo, name: user_data['name']});
               // setIsLoggedIn(true);
               setIsInUserTable(true);
            } else {
                console.log("Status: " + data['status']);
            }
        })
        .catch((error) => {
            console.error("Error: ", error);
        });
    }

    const logIn = () => {
        console.log("Log in button");
        if(loginModalFields['name']==""||loginModalFields['password']=="")
            alert("Please enter your name and password")
        else
        {
            //setIsInUserTable(true);
            console.log(loginModalFields['name']);
            //setUserInfo({...userInfo, name: user_data['name']});
        }
        
       
    }
    //Update Location fields 
    function updateRoomLocation(e){
        setCreateRoomFields({...createRoomFields, location: parseInt(e.target.value)})
    }

    //update user type field
    function updateUserTypeField(e){
        setSignUpFields({...signUpFields, type_of_user: e.target.value})
        //console.log(e.target.value);
        //console.log(signUpFields["type_of_user"])
    }

    function updateRestaurantLocation(e){
        setAddRestaurantFields({...addRestaurantFields, location: parseInt(e.target.value)})
    }

    //for logging out
    function handleLogOut(){
        if(isInUserTable)
            {
                console.log("is in session")
                fetch('/log_out')
            }
        else
        {
            console.log ("a guest");
        }
        
        setIsLoggedIn(false);
        if (!isLoggedIn){
            console.log("logged out");
        }
    }

    //Join room request
    const joinRoomRequest=() => {
       
        if(isGuestUser&&!isInUserTable)
        {
            console.log("guest user: join room");
            signInAsGuest();
        }
        console.log ("you have joined with token ")
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
                console.log("in redirection")
                window.location.href = response.url;
            }
            else{
                alert("Invalid token; try again")
            }
        })
        /*.then(data => {
            console.log("in data");
            console.log(data);
            console.log(status);
            if (data['status'] == 200) {
                console.log("OK")
            } else if (data['status'] == 460){
                console.log("Status: " + data['status']);
            }
        })*/
    }

    //Create Room Request
    const createRoomRequest=() => {
        if(isGuestUser&&!isInUserTable)
        {
            console.log("guest user: create room")
            signInAsGuest();
        }
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
        if(isGuestUser&&!isInUserTable)
        {
            console.log("guest user: add restaurant")
            signInAsGuest();
        }
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
    const signUp=() => {
        console.log("in sign up");
        setshowSignUpModal(true);
    }
    const createAccount=(e) => {
        console.log("createAccount ");
        console.log(signUpFields['name'], " + ", signUpFields['type_of_user'], "+ ",signUpFields['password']);
        if(signUpFields['password']==""||signUpFields['confirm_password']==""||signUpFields['name']=="")
            alert ("Please fill up all the fields");
        else if (signUpFields['password']!=signUpFields['confirm_password'])
            alert("Passwords are not matched");
        
    }
    return (
        <div className="container">
            <div>Welcome to our app {userInfo["name"]}</div>
            <div className="input-group input-group-sm mb-3">
                    <div className="input-group-prepend">
                        <span className="input-group-text" id="inputGroup-sizing-sm">Name</span>
                    </div>
                    <input type="text" className="form-control" aria-label="Small" aria-describedby="inputGroup-sizing-sm" onChange={e => setGuestNameFields({...guestNameField, name: e.target.value})} value={guestNameField['name']}/>
                </div>
            
            <button type="button" className="btn btn-primary" onClick={handleJoinRoomShow}>Join room</button><br/><br/>
            <button type="button" className="btn btn-primary" onClick={handleCreateRoomShow}>Create Room</button><br/><br/>
            <button type="button" className="btn btn-primary" onClick={handleAddRestaurantShow}>Add Restaurant</button><br/><br/>
            <button type="button" className="btn btn-primary" onClick={handleLogOut}>Log Out</button>

            <Modal show={!isLoggedIn}>
                <Modal.Header >
                    <Modal.Title>Sign-in to Proceed</Modal.Title>
                </Modal.Header>

                <div className="input-group input-group-sm mb-3">
                    <div className="input-group-prepend">
                        <span className="input-group-text" id="inputGroup-sizing-sm">Name</span>
                    </div>
                    <input type="text" className="form-control" aria-label="Small" aria-describedby="inputGroup-sizing-sm" onChange={e => setLoginModalFields({...loginModalFields, name: e.target.value})} value={loginModalFields['name']}/>
                </div>
                <div className="input-group input-group-sm mb-3">
                    <div className="input-group-prepend">
                        <span className="input-group-text" id="inputGroup-sizing-sm">Password</span>
                    </div>
                    <input type="password" className="form-control" aria-label="Small" aria-describedby="inputGroup-sizing-sm" onChange={e => setLoginModalFields({...loginModalFields, password: e.target.value})} value={loginModalFields['password']}/>
                </div>
                <div>
                <Button variant="primary" onClick={logIn}>
                    Log in
                    </Button>
                </div>
                <Modal.Footer>
                    <div>
                        Don't have an account?
                    </div>
                    <Button variant="primary" onClick={continueAsGuest}>
                    Continue as a Guest
                    </Button>
                    <Button variant="primary" onClick={signUp}>
                    Sign Up
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
                        <span className="input-group-text" id="inputGroup-sizing-sm">Room Name</span>
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


            <Modal show={showSignUpModal} onHide={handleSignUpClose}>
                <Modal.Header closeButton>
                    <Modal.Title>Sign up!</Modal.Title>
                </Modal.Header>
                <Modal.Body>Hey, create your account..</Modal.Body>

                <div className="input-group input-group-sm mb-3">
                    <div className="input-group-prepend">
                        <span className="input-group-text" id="inputGroup-sizing-sm">Name</span>
                    </div>
                    <input type="text" className="form-control" aria-label="Small" aria-describedby="inputGroup-sizing-sm" onChange={e => setSignUpFields({...signUpFields, name: e.target.value})} value={signUpFields['name']}/>
                </div>
                <div className="input-group input-group-sm mb-3">
                    <div className="input-group-prepend">
                        <span className="input-group-text" id="inputGroup-sizing-sm">Password</span>
                    </div>
                    <input type="password" className="form-control" aria-label="Small" aria-describedby="inputGroup-sizing-sm" onChange={e => setSignUpFields({...signUpFields, password: e.target.value})} value={signUpFields['password']}/>
                </div>
                <div className="input-group input-group-sm mb-3">
                    <div className="input-group-prepend">
                        <span className="input-group-text" id="inputGroup-sizing-sm">Confirm Password</span>
                    </div>
                    <input type="password" className="form-control" aria-label="Small" aria-describedby="inputGroup-sizing-sm" onChange={e => setSignUpFields({...signUpFields, confirm_password: e.target.value})} value={signUpFields['confirm_password']}/>
                </div>
                <div className="input-group input-group-sm mb-3">
                    <div className="input-group-prepend">
                        <span className="input-group-text" id="inputGroup-sizing-sm">User Type</span>
                    </div>
                    <div>
                            <select value={signUpFields["type_of_user"]} onChange={updateUserTypeField} >
                                <option  value="regular" >Regular User</option>
                                <option  value="owner" >Restaurant Owner</option>
                                
                            </select>
                    </div>
                </div>
                
                <Modal.Footer>
                    <Button variant="secondary" onClick={handleSignUpClose}>
                        Close
                    </Button>
                    <Button variant="primary" onClick={createAccount}>
                        Create
                    </Button>
                </Modal.Footer>
            </Modal>
        </div>
    );
}

export default Homepage 