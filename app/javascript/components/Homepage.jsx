import React from 'react'
import { useState, useEffect } from "react";
import { Form } from 'react-bootstrap';
import Modal from 'react-bootstrap/Modal';
import Button from 'react-bootstrap/Button';

const Homepage = (props) => {

    const [showCreateRoomModal, setShowCreateRoomModal] = useState(false);
    const [showJoinRoomModal, setShowJoinRoomModal] = useState(false);
    const [createRoomFields, setCreateRoomFields] = useState({
        name: "",
        location: "",
        token: "",
    });
    const [joinRoomFields, setJoinRoomFields] = useState({
        name: "",
        token: "",
    });

    const handleCreateRoomClose = () => setShowCreateRoomModal(false);
    const handleCreateRoomShow = () => setShowCreateRoomModal(true);
    const handleJoinRoomClose = () => setShowJoinRoomModal(false);
    const handleJoinRoomShow = () => setShowJoinRoomModal(true);


    return (
        <div class="container-fluid">
            <button type="button" class="btn btn-primary" onClick={handleJoinRoomShow}>Join room</button>

            <button type="button" class="btn btn-primary" onClick={handleCreateRoomShow}>Create Room</button>


            <Modal show={showJoinRoomModal} onHide={handleJoinRoomClose}>
                <Modal.Header closeButton>
                    <Modal.Title>Join Room</Modal.Title>
                </Modal.Header>
                <Modal.Body>Woohoo, you're reading this text in a modal!</Modal.Body>

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
                    <Button variant="primary" onClick={handleJoinRoomShow}>
                    Join the Room!
                    </Button>
                </Modal.Footer>
            </Modal>




            <Modal show={showCreateRoomModal} onHide={handleCreateRoomClose}>
                <Modal.Header closeButton>
                    <Modal.Title>Create Room</Modal.Title>
                </Modal.Header>
                <Modal.Body>Woohoo, you're reading this text in a modal!</Modal.Body>

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
                    <input type="text" className="form-control" aria-label="Small" aria-describedby="inputGroup-sizing-sm" onChange={e => setCreateRoomFields({...createRoomFields, location: e.target.value})} value={createRoomFields['location']}/>
                </div>
                <div className="input-group input-group-sm mb-3">
                    <div className="input-group-prepend">
                        <span className="input-group-text" id="inputGroup-sizing-sm">Room Token</span>
                    </div>
                    <input type="text" className="form-control" aria-label="Small" aria-describedby="inputGroup-sizing-sm" onChange={e => setCreateRoomFields({...createRoomFields, token: e.target.value})} value={createRoomFields['token']}/>
                </div>

                <Modal.Footer>
                    <Button variant="secondary" onClick={handleCreateRoomClose}>
                        Close
                    </Button>
                    <Button variant="primary" onClick={handleCreateRoomShow}>
                    Create the Room!
                    </Button>
                </Modal.Footer>
            </Modal>
        </div>
    );

    // return (
    // <div class="container-fluid">
    //     <div>hello asdfasdfasdfaasdfasdf;</div>
    //         <Form>
    //             <Form.Group controlId="formBasicEmail">
    //             <Form.Label>Email address</Form.Label>
    //             <Form.Control type="email" placeholder="Enter email" />
    //             <Form.Text className="text-muted">
    //             We'll never share your email with anyone else.
    //             </Form.Text>
    //         </Form.Group>

    //         <Form.Group controlId="formBasicPassword">
    //             <Form.Label>Password</Form.Label>
    //             <Form.Control type="password" placeholder="Password" />
    //         </Form.Group>
    //         <Form.Group controlId="formBasicCheckbox">
    //             <Form.Check type="checkbox" label="Check me out" />
    //         </Form.Group>
    //         <Button variant="primary" type="submit">
    //             Submit
    //         </Button>
    //     </Form>
    // </div>
    // );
}

export default Homepage 