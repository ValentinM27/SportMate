import React, {Component} from 'react';

class SelectByCrud extends Component {
    render() {
        return (
            <div className="select-content">
                <h2>Rechercher par type d'opération</h2>
                <ul>
                    <li>
                        Create
                    </li>

                    <li>
                        Read
                    </li>

                    <li>
                        Update
                    </li>

                    <li>
                        Delete
                    </li>
                </ul>
            </div>
        );
    }
}

export default SelectByCrud;