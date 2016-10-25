import React, { Component } from 'react'
import { Link, browserHistory, withRouter } from 'react-router'

class IndexRequest extends Component {
  constructor(props) {
    super(props);
    this.state = {
      requests: [],
      users: [],
      pokemon: []
    }

  }

  componentDidMount() {
    $("#not-app").hide();

    $.ajax({
      url: "/api/v1/requests"
    }).done(data => {
      this.setState(data)
    })
  }

  render() {

    let allRequests = this.state.requests.map(request => {
      let user = $.grep(this.state.users, function(e){ return e.id === request.user_id })[0]
      let pokemon =  $.grep(this.state.pokemon, function(e){ return e.id === request.pokemon_id })[0]

      let typeB
      if(pokemon.typeB) {
        typeB = <img src={"/assets/types/" + pokemon.typeB + ".png"}/>
      }
      let typeA = <img src={"/assets/types/" + pokemon.typeA + ".png"}/>


      return(
        <div className="row">
          <div id={`request${request.id}`} className="text-center columns small-3 pokediv">
            <h5>{user.username}s {pokemon.name}</h5><hr/>
            <Link to={`requests/${request.id}`} id={`poke-link${request.id}`}><img className="poke-sprite" src={`/assets/${pokemon.sprite}`}/></Link>
          </div>
          <div id={`request-detail${request.id}`} className="columns small-8 float-left">
            <div className="">
              {typeB}
              {typeA}
            </div>
            <h5><strong>Description: </strong>{request.description}</h5>
          </div>
          <div className="columns small-12">
            <hr/>
          </div>
        </div>
      )
    })

    return(
      <div>
        <div className="row page-head">
          <div className="columns small-12">
            <h1>All Current Trade Requests</h1>
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
        {allRequests}
      </div>
    )
  }
}

export default IndexRequest
