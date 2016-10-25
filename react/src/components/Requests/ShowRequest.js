import React, { Component } from 'react'
import { Link, browserHistory, withRouter } from 'react-router'

class ShowRequest extends Component {
  constructor(props) {
    super(props);
    this.state = {
      pokemon: {},
      request: {},
      owner: {},
      user: {},
      active: {}
    }
    this.handleRequestDeletion = this.handleRequestDeletion.bind(this)
  }

  componentDidMount() {
    $("#not-app").hide();

    $.ajax({
      url: "/api/v1/requests/" + this.props.params.requestId
    }).done(data => {
      debugger;
      this.setState({
        pokemon: data.pokemon,
        request: data.request,
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

  handleRequestDeletion(e) {
    e.preventDefault();
    let _this = this
    $.ajax({
      url: '/api/v1/requests/' + this.props.params.requestId,
      type: 'DELETE',
      success: function(data) {
        _this.context.router.push(data.path)
      }
    });
  }


  render() {
    debugger;
    let editButton
    let deleteButton
    let tradeButton
    if(this.state.owner.id == this.state.user.id){
      editButton = <Link to={`/requests/${this.state.request.id}/edit`} className="button">Edit Request</Link>
      deleteButton = <Link to="/" className="button" onClick={this.handleRequestDeletion}>Delete Request</Link>
      tradeButton = <a className="button disabled">You cannot request to trade with yourself</a>
    } else if(this.state.user.id == null) {
      tradeButton = <a href="/users/sign_in" className="button">You must be logged in to request a trade</a>
    } else if(this.state.user.id == this.state.active.user_id){
      tradeButton = <a className="button disabled">You have already sent a trade request</a>
    } else {
      tradeButton = <a href={`/users/${this.state.request.id}/request_trade_mail`} className="button">Send A Trade Request</a>
    }

    let typeB
    if(this.state.pokemon.typeB) {
      typeB = <img src={"/assets/types/" + this.state.pokemon.typeB + ".png"}/>
    }
    let typeA = <img src={"/assets/types/" + this.state.pokemon.typeA + ".png"}/>

    return (
      <div>
        <div className="row page-head">
          <div className="columns small-8">
            <h2>{this.state.owner.username}'s Trade Request for {this.state.pokemon.name}</h2>
          </div>
        </div>

        <div className="row search-bar">
          <div className="columns small-12">

          </div>
        </div>

        <div className="row">
          <div id={"request" + this.state.request.id} className="text-center columns small-3 pokediv">
            <h5>{this.state.owner.username}'s<br/>{this.state.pokemon.name} Request</h5><hr/>
            <img src={"/assets/" + this.state.pokemon.sprite} className="poke-sprite"/>
          </div>
          <div id={"request-detail" + this.state.request.id} className="columns small-8 float-left">
            <div className="">
              {typeB}
              {typeA}
            </div>
            <h5><strong>Description: </strong>{this.state.request.description}</h5>
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

ShowRequest.contextTypes = {
  router: React.PropTypes.object.isRequired
}

export default ShowRequest
