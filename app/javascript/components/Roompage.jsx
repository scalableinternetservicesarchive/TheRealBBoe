import React from 'react'
import { useState, useEffect } from "react";
import { Form } from 'react-bootstrap';
import Modal from 'react-bootstrap/Modal';
import Button from 'react-bootstrap/Button';

const Roompage = (props) => {
    const [restaurants, setRestaurants] = useState(props.restaurants)
        let optionItems = restaurants.map((r) =>
                <Button  value={r.id} key={r.name}>{r.name}</Button>
            );
    return (
        <div>
            <br/>
            <br/>
            "Hello in the room"
           
            <div>
                            
                                {optionItems}
                            
                    </div>
        </div>
    );

}

export default Roompage 