import React, { Component } from 'react'
import { Link, browserHistory, withRouter } from 'react-router'

class ShowPokeball extends Component {
  constructor(props) {
    super(props);
    this.state = {
      pokemon: {},
      pokeball: {},
      owner: {},
      user: {},
      active: {}
    }
  }

  componentDidMount() {
    $("#not-app").hide();

    $.ajax({
      url: "/api/v1/pokeballs/" + this.props.params.pokeballId
    }).done(data => {
      debugger;
      this.setState({
        pokemon: data.pokemon,
        pokeball: data.pokeball,
        owner: data.owner
      })
      if (data.active) {
        this.setState({ active: data.active })
      }
      if (data.user) {
        this.setState({ user: data.user })
      }
    })
  }
  render() {

    let editButton
    let deleteButton
    let tradeButton
    if(this.state.owner.id == this.state.user.id){
      editButton = <Link to={`/pokeballs/${this.state.pokeball.id}/edit`} className="button">Edit Offer</Link>
      deleteButton = <a href={`/pokeballs/${this.state.pokeball.id}`} className="button" rel="nofollow" data-method="delete">Delete Offer</a>
      tradeButton = <a className="button disabled">You cannot request to trade with yourself</a>
    } else if(this.state.user.id == null) {
      tradeButton = <a href="/users/sign_in" className="button">You must be logged in to request a trade</a>
    } else if(this.state.user.id == this.state.active.id){
      tradeButton = <a className="button disabled">You have already sent a trade request</a>
    } else {
      tradeButton = <a href={`/users/${this.state.pokeball.id}/send_trade_mail`} className="button">Send A Trade Request</a>
    }

    let typeB
    if(this.state.pokemon.typeB) {
      typeB = <img src={"/assets/types/" + this.state.pokemon.typeB + ".png"}/>
    }
    let typeA = <img src={"/assets/types/" + this.state.pokemon.typeA + ".png"}/>
    let hpIV = <strong>HP: {this.state.pokeball.hpIV ? this.state.pokeball.hpIV : "?"}</strong>
    let atkIV = <strong>Atk: {this.state.pokeball.attIV ? this.state.pokeball.attIV : "?"}</strong>
    let defIV = <strong>Def: {this.state.pokeball.defIV ? this.state.pokeball.defIV : "?"}</strong>
    let spaIV = <strong>SpA: {this.state.pokeball.spaIV ? this.state.pokeball.spaIV : "?"}</strong>
    let spdIV = <strong>SpD: {this.state.pokeball.spdIV ? this.state.pokeball.spdIV : "?"}</strong>
    let speIV = <strong>Spe: {this.state.pokeball.speIV ? this.state.pokeball.speIV : "?"}</strong>

    return (
      <div>
        <div className="row page-head">
          <div className="columns small-8">
            <h2>{this.state.owner.username}'s Trade Offer for {this.state.pokemon.name}</h2>
          </div>
        </div>

        <div className="row search-bar">
          <div className="columns small-12">

          </div>
        </div>

        <div className="row">
          <div id={"offer" + this.state.pokeball.id} className="text-center columns small-3 pokediv">
            <h5>{this.state.owner.username}'s {this.state.pokemon.name}</h5><hr/>
            <img src={"/assets/" + this.state.pokemon.sprite} className="poke-sprite"/>
          </div>
          <div id={"offer-detail" + this.state.pokeball.id} className="columns small-8 float-left">
            <h5><strong>Level: {this.state.pokeball.level}</strong>{}</h5>
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
            <h5><strong>Description: </strong>{this.state.pokeball.description}</h5>
          </div>
        </div>
        <div className="row button-row">
          {editButton}
          {deleteButton}
          {tradeButton}
        </div>
      </div>
    )
  }
}

export default ShowPokeball
