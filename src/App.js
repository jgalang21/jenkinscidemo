import logo from './logo.svg';
import './App.css';

function App() {

  const handleClick = () => {
    console.log('button clicked');
  };

  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn Docker
        </a>

        <button onClick={handleClick}>Click me</button>
      </header>
    </div>
  );
}

export default App;
