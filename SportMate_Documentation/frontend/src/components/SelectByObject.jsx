import React, {Component} from 'react';
import {Link} from "react-router-dom";

class SelectByObject extends Component {
    render() {
        return (
            <div className="select-content">
                <h2>Rechercher par type d'objet</h2>
                <ul>
                    <li>
                        <Link to="/event">
                            Event
                        </Link>
                    </li>

                    <li>
                        <Link to="/auth">
                            User / Authentication
                        </Link>
                    </li>

                    <li>
                        <Link to="/join">
                            Join (Event)
                        </Link>
                    </li>

                    <li>
                        <Link to="/sport">
                            Sport
                        </Link>
                    </li>

                    <li>
                        <Link to="/comment">
                            Comment
                        </Link>
                    </li>

                    <li>
                        <Link to="/friend">
                            Friend
                        </Link>
                    </li>

                    <li>
                        <Link to="/test">
                            Test
                        </Link>
                    </li>
                </ul>

                <h2>Database</h2>
                <ul>
                    <li>
                        <Link to="/dataType">
                            Type de données
                        </Link>
                    </li>
                </ul>
            </div>
        );
    }
}

export default SelectByObject;