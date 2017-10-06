import React, { Component } from 'react'
import { Link, browserHistory, withRouter } from 'react-router'

class UserShow extends Component {
  constructor(props) {
    super(props);
    this.state = {
      user: '',
      owner: '',
      pokeballs: [],
      requests: [],
      pokemon: []
    }

  }

  componentDidMount() {
    $.ajax({
      url: "/api/v1/users/" + this.props.params.userId,
    }).done(data => {
      this.setState({
        user: data.user,
        owner: data.owner,
        pokeballs: data.pokeballs,
        requests: data.requests,
        pokemon: data.pokemon
      })
    })
  }

  render() {

    $("#not-app").hide();
    let editProfile;

    let pokeballs = this.state.pokeballs.map((pokeball, index) => {
      let pokemon = $.grep(this.state.pokemon, function(e){ return e.id === pokeball.pokemon_id })[0];

      let lineBreak;
      if(index % 3 == 2){
        lineBreak = <div className="columns small-12"><hr/></div>
      }

      return(
        <div>
          <div id={`offer${pokeball.id}`} className="text-center columns small-3 pokediv float-left">
            <h5>{this.state.owner.username}s<br/>{pokemon.name}</h5><hr/>
            <Link to={`/pokeballs/${pokeball.id}`} id={`offer-poke-link${pokeball.id}`}>
              <img src={`/assets/${pokemon.sprite}`}/>
            </Link>
          </div>
          {lineBreak}
        </div>
      )
    });

    let requests = this.state.requests.map((request, index) => {
      let pokemon = $.grep(this.state.pokemon, function(e){ return e.id === request.pokemon_id })[0];

      let lineBreak;
      if(index % 3 == 2){
        lineBreak = <div className="columns small-12"><hr/></div>
      }

      return(
        <div>
          <div id={`request${request.id}`} className="text-center columns small-3 pokediv float-left">
            <h5>{pokemon.name}<br/>Request</h5><hr/>
            <Link to={`/requests/${request.id}`} id={`request-poke-link${request.id}`}>
              <img src={`/assets/${pokemon.sprite}`}/>
            </Link>
          </div>
          {lineBreak}
        </div>
      )
    });

    if(this.state.owner.id == this.state.user.id) {
      editProfile = <a href="/users/edit" className="button">Edit Profile</a>
    }

    return(
      <div>
        <div className="row page-head text-center">
          <div className="columns small-12">
            <h1>{this.state.owner.username}'s Profile</h1>
          </div>
        </div>
        <div className="row button-row">
          <div className="columns small-12">
            {editProfile}
          </div>
        </div>

        <div className="row">
          <h3 className="trade-bar">{this.state.owner.username}s Pokemon</h3>
        </div>
        <div className="row">
          {pokeballs}
        </div>

        <div className="row">
          <h3 className="trade-bar">{this.state.owner.username}s Requests</h3>
        </div>
        <div className="row">
          {requests}
        </div>
      </div>
    )
  }
}

export default UserShow
