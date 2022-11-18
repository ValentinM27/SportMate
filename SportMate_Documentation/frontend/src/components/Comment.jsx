import React, {Component} from 'react';
import UserOperation from "../Helpers/CommentOperation";

class Comment extends Component {
    render() {
        return (
            <div className="type-container">
                {UserOperation.map((pass) =>(
                    <div className="type-content">
                        <h2 key={pass.id}>{pass.name}</h2>
                        <p>{pass.desc}</p>
                        <h3 id="auth">{pass.isAuth}</h3>
                        <h3>Structure du Json à envoyer : </h3>
                        <p>{pass.jsonEnt}</p>
                        <h3>Structure du Json retourné : </h3>
                        <p>{pass.jsonRet}</p>
                    </div>
                ))}
            </div>
        );
    }
}

export default Comment;