import React, { Component } from 'react'
import { Link, browserHistory, withRouter } from 'react-router'

class IndexPokeball extends Component {
  constructor(props) {
    super(props);
    this.state = {
      pokeballs: [],
      users: [],
      pokemon: [],
      pokeSearch: ''
    }
    this.handleChange = this.handleChange.bind(this)
  }

  componentDidMount() {
    $("#not-app").hide();

    $.ajax({
      url: "/api/v1/pokeballs"
    }).done(data => {
      this.setState(data)
    })
  }

  handleChange(e) {
    this.setState({ pokeSearch: e.target.value })
    $.ajax({
      url: "/api/v1/pokeballs/1/search",
      type: "GET",
      data: { getPoke: e.target.value }
    }).done(data =>{
      this.setState({ pokeballs: data.pokeballs })
    })
  }

  render() {

    let whomp
    if(!this.state.pokeballs[0]){
      whomp = <div>Uh oh! No search matches</div>
    }

    let allPokeballs = this.state.pokeballs.map(pokeball => {
      let user = $.grep(this.state.users, function(e){ return e.id === pokeball.user_id })[0]
      let pokemon = $.grep(this.state.pokemon, function(e){ return e.id === pokeball.pokemon_id })[0]
      let hpIV = <strong>HP: {pokeball.hpIV ? pokeball.hpIV : "?"}</strong>
      let atkIV = <strong>Atk: {pokeball.attIV ? pokeball.attIV : "?"}</strong>
      let defIV = <strong>Def: {pokeball.defIV ? pokeball.defIV : "?"}</strong>
      let spaIV = <strong>SpA: {pokeball.spaIV ? pokeball.spaIV : "?"}</strong>
      let spdIV = <strong>SpD: {pokeball.spdIV ? pokeball.spdIV : "?"}</strong>
      let speIV = <strong>Spe: {pokeball.speIV ? pokeball.speIV : "?"}</strong>

      let typeB
      if(pokemon.typeB) {
        typeB = <img src={"/assets/types/" + pokemon.typeB + ".png"}/>
      }
      let typeA = <img src={"/assets/types/" + pokemon.typeA + ".png"}/>

      return(
        <div className="row">
          <div id={`offer${pokeball.id}`} className="text-center columns small-3 pokediv">
            <h5>{user.username}'s {pokemon.name}</h5><hr/>
            <Link to={`pokeballs/${pokeball.id}`} id={`poke-link${pokeball.id}`}><img className="poke-sprite" src={`/assets/${pokemon.sprite}`}/></Link>
          </div>
          <div id={`offer-detail${pokeball.id}`} className="columns small-8 float-left">
            <h5><strong>Level: </strong>{pokeball.level}</h5>
            <div className="">
              {typeB}
              {typeA}
            </div>
            <h4 className="inline">IVs:</h4>
            <em>
              <a href="http://bulbapedia.bulbagarden.net/wiki/Individual_values" target="_blank">
                (What are IVs?)
              </a>
            </em>
            <div className="row">
              <h5 className="iv columns small-1 float-left">{hpIV}</h5>
              <h5 className="iv columns small-1 float-left">{atkIV}</h5>
              <h5 className="iv columns small-1 float-left">{defIV}</h5>
              <h5 className="iv columns small-1 float-left">{spaIV}</h5>
              <h5 className="iv columns small-1 float-left">{spdIV}</h5>
              <h5 className="iv columns small-1 float-left">{speIV}</h5>
            </div>
            <h5><strong>Description: </strong>{pokeball.description}</h5>
          </div>
          <div className="columns small-12">
            <hr/>
          </div>
        </div>
      )
    })

    return(
      <div>
        <div className="row page-head text-center">
          <div className="columns small-12">
            <h1>All Current Trade Offers</h1>
          </div>
        </div>

        <div className="row">
          <div className="columns-12 flash-bar text-center">
          </div>
        </div>

        <div className="row search-bar">
          <div className="columns small-12">
            <input type="text" onChange={this.handleChange}/>
          </div>
        </div>
        {whomp}
        {allPokeballs}
      </div>
    )
  }
}

export default IndexPokeball
