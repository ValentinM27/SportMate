import './style/Global.scss';
import {HashRouter, Link, Route, Switch} from "react-router-dom";
import {Test, SelectByObject, DataType, Auth, Event, Friend, Join, Sport, Comment} from "./components/index";

function App() {
  return (
    <div className="App">
        <HashRouter>
            <header>
                <h1>Bienvenue sur la documentation de l'API de Sport'Mate <br />
                    <Link id="button-home" to="/">
                        Retourner à l'accueil
                    </Link>
                </h1>

                <h2 id="warning">
                    ATTENTION, LES JSON SONT SENSIBLES A LA CASE !
                </h2>

                <h3>
                    Lien api : appart.dialyx.fr:9670/TOKEN
                </h3>

            </header>

            <Switch>
                <Route path="/" exact component={() => <SelectByObject />} />
                <Route path="/test" exact component={() => <Test />} />
                <Route path="/dataType" exact component={() => <DataType/>} />
                <Route path="/auth" exact component={() => <Auth />} />
                <Route path="/event" exact component={() => <Event />} />
                <Route path="/friend" exact component={() => <Friend />} />
                <Route path="/join" exact component={() => <Join />} />
                <Route path="/sport" exact component={() => <Sport />} />
                <Route path="/comment" exact component={() => <Comment />} />
            </Switch>

        </HashRouter>
    </div>
  );
}

export default App;
