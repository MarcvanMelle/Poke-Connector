import React, { Component } from 'react'
import { Link, browserHistory, withRouter } from 'react-router'

class HomePage extends Component {
  constructor(props){
    super(props);
    this.state = {
      intervalId: null,
      pokeballs: [],
      pokeball: null,
      pokemon: [],
      users: []
    };
    this.handleClearTimer = this.handleClearTimer.bind(this);
    this.timer = this.timer.bind(this)
  }

  componentDidMount() {
    $("#not-app").hide();

    this.setState({ intervalId: setInterval(this.timer, 2000) });

    $.ajax({
      url: "/api/v1/pokeballs"
    }).done(data => {
      this.setState({
        pokeballs: data.pokeballs,
        pokemon: data.pokemon,
        users: data.users
      });
      this.setState({
        pokeball: this.state.pokeballs[0]
      })
    })
  }

  componentWillUnmount() {
    clearInterval(this.state.intervalId);
  }

  handleClearTimer() {
    clearInterval(this.state.intervalId);
  }

  timer() {
    let rand = Math.floor(Math.random() * this.state.pokeballs.length);
    this.setState({ pokeball: this.state.pokeballs[rand] })
  }

  render() {
    let homepage, pokemon, owner, offer;
    if(this.state.pokeball){
      offer = this.state.pokeball;
      pokemon = this.state.pokemon[offer.pokemon_id - 1];
      owner = $.grep(this.state.users, function(e){ return e.id === offer.user_id })[0]
    }
    if(location.pathname == "/" && pokemon){
      let hpIV = <div><strong>HP: </strong>{this.state.pokeball.hpIV ? this.state.pokeball.hpIV : "?"}</div>;
      let atkIV = <div><strong>Atk: </strong>{this.state.pokeball.attIV ? this.state.pokeball.attIV : "?"}</div>;
      let defIV = <div><strong>Def: </strong>{this.state.pokeball.defIV ? this.state.pokeball.defIV : "?"}</div>;
      let spaIV = <div><strong>SpA: </strong>{this.state.pokeball.spaIV ? this.state.pokeball.spaIV : "?"}</div>;
      let spdIV = <div><strong>SpD: </strong>{this.state.pokeball.spdIV ? this.state.pokeball.spdIV : "?"}</div>;
      let speIV = <div><strong>Spe: </strong>{this.state.pokeball.speIV ? this.state.pokeball.speIV : "?"}</div>;
      homepage = (
        <div>
          <h4 className="text-center">Featured Pokemon:</h4>
          <div className="row featured">
            <div className="columns small-8 small-centered text-center">
              <h5>{owner.username}'s {pokemon.name}</h5><hr/>
              <Link onClick={this.handleClearTimer} to={`pokeballs/${this.state.pokeball.id}`}><img src={`/assets/${pokemon.sprite}`}/></Link>
            </div>
          </div>
          <div className="row">
            <div className="columns small-12 medium-8 large-4 small-centered">
              <div className="columns small-4 float-left">
                <strong>Level: </strong>{this.state.pokeball.level}
              </div>
              <div className="columns small-8 medium-8 float-left row">
                <div className="columns small-4 medium-6 float-left">
                  {hpIV}
                  {atkIV}
                  {defIV}
                </div>
                <div className="columns small-4 medium-6 float-left">
                  {spaIV}
                  {spdIV}
                  {speIV}
                </div>
              </div>
            </div>
          </div>
        </div>
      )
    }

    return (
      <div>
        <div className="row page-head text-center">
          <div className="columns small-12">
            <h1>Poke-Connector</h1>
          </div>
        </div>

        <div className="row">
          <div className="columns-12 flash-bar text-center">
          </div>
        </div>

        <div className="row search-bar">
          <div className="columns small-12">

          </div>
        </div>

        {homepage}
        <div className="row">
          <div className="columns small-10 small-centered">
            <hr/>
          </div>
        </div>
        <div className="row">
          <div className="columns small-8 small-centered">
            <div>
              <h3>Welcome to Poke-Connector</h3>
              <div className="columns small-11">
                <p>
                  With over 720 currently available Pokemon, catching them all
                  has become a significant undertaking. Poke-Connector is here
                  to help. Whether you're new to the game, or a veteran trainer,
                  Poke-Connector provides you the resources to offer your Pokemon and
                  place trade requests with your fellow Poke-Masters.
                </p>
                <p>
                  Happy trading!
                </p>
              </div>
            </div>
          </div>
        </div>
        <div className="row">
          <div className="columns small-10 small-centered">
          </div>
        </div>
        <div className="row">
          <div className="columns small-8 small-centered" id="News will go here eventually">
            <h3></h3>
          </div>
        </div>
        <div className="row">
          <div className="columns small-10 small-centered">
          </div>
        </div>
      </div>
    )
  }
}

HomePage.contextTypes = {
  router: React.PropTypes.object.isRequired
};

export default HomePage
