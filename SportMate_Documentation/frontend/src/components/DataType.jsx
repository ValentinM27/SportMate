import React, {Component} from 'react';

class DataType extends Component {
    render() {
        return (
            <div className="table-wrapper">
                <table className="fl-table">
                    <thead>
                        <tr>
                            <th>Data</th>
                            <th>Format</th>
                        </tr>
                    </thead>

                    <tbody>
                        <tr>
                            <td>Sexe</td>
                            <td>'H' (Homme), 'F' (Femme), 'N' (Neutre)</td>
                        </tr>

                        <tr>
                            <td>BirthdayDate</td>
                            <td>YYYY-MM-DD</td>
                        </tr>
                        <tr>
                            <td>TypeEvent</td>
                            <td>'Cours', 'Competition', 'Entrainement'</td>
                        </tr>
                    </tbody>

                </table>
            </div>
        );
    }
}

export default DataType;