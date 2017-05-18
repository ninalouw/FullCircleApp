import React, { Component } from 'react';
// import logo from './logo.svg';
import './App.css';
import $ from 'jquery';
import GoalList from './GoalList';
import apiKeys from './apiKeys';
import NewGoalModal from './newGoalModal';
import EditGoalModal from './editGoalModal';
import DeleteGoalModal from './deleteGoalModal';
import GoalDoughnutChart from './DoughnutChart';
import injectTapEventPlugin from 'react-tap-event-plugin';
import MuiThemeProvider from 'material-ui/styles/MuiThemeProvider';
import FloatingActionButton from 'material-ui/FloatingActionButton';
import ContentAdd from 'material-ui/svg-icons/content/add';
import AppBar from 'material-ui/AppBar';

class App extends Component {
  constructor (props) {
    super(props);

    this.state = {
      goals: [],
      goal: "",
      newModalIsOpen: false,
      editModalIsOpen: false,
      deleteModalIsOpen: false,
      goalBeingEdited: null,
      newGoal: ""
    };
    this.setGoalAsDone = this.setGoalAsDone.bind(this);
    this.openModal = this.openModal.bind(this);
    this.openEditModal = this.openEditModal.bind(this);
    this.closeModal = this.closeModal.bind(this);
    this.handleEditNameChange = this.handleEditNameChange.bind(this);
    this.handleEditMinutesChange = this.handleEditMinutesChange.bind(this);
    this.handleEditSubmit = this.handleEditSubmit.bind(this);
    this.handleNewNameChange = this.handleNewNameChange.bind(this);
    this.handleNewMinutesChange = this.handleNewMinutesChange.bind(this);
    this.handleNewSubmit = this.handleNewSubmit.bind(this);
    this.handleDeleteSubmit = this.handleDeleteSubmit.bind(this);
    this.openDeleteModal = this.openDeleteModal.bind(this);
  }

  //ajax request to fetch goals
  componentWillMount () {
    this.getGoals();
  }


//this function is used to set goals as done on change of checkbox
  setGoalAsDone (event) {
    const goalIndex = parseInt(event.currentTarget.getAttribute('data-index'), 10);
    let tempGoals = this.state.goals;
    tempGoals = tempGoals.map(
      (goal) => {
        if (goal.id === goalIndex) {
          goal.done = true;

        }
        return goal;
      }
    );

    this.setState({ goals: tempGoals });
    this.postCheckedGoals(goalIndex);
  }

  //Functions for our Modal
  openModal () {
    this.setState({ newModalIsOpen: true });
  }

  openDeleteModal (event) {
    const goalIndex = parseInt(event.currentTarget.getAttribute('data-index'), 10);
    let tempGoals = this.state.goals;
    tempGoals = tempGoals.filter(
      (goal) => {
        if (goal.id === goalIndex) {
          return true;
        } else {
          return false;
        }
      }
    );
    this.setState({ goalBeingEdited: tempGoals[0] });
    this.setState({ deleteModalIsOpen: true });
  }

//this func gets called on click of edit button, it gets the goal clicked by id
//and then populates the editGoalModal with the information
  openEditModal (event) {
    const goalIndex = parseInt(event.currentTarget.getAttribute('data-index'), 10);
    let tempGoals = this.state.goals;
    tempGoals = tempGoals.filter(
      (goal) => {
        if (goal.id === goalIndex) {
          return true;
        } else {
          return false;
        }
      }
    );
    this.setState({ goalBeingEdited: tempGoals[0] });
    this.setState({ editModalIsOpen: true });
  }

  closeModal () {
    this.setState({ newModalIsOpen: false, editModalIsOpen: false, deleteModalIsOpen: false });
  }

  //function to deal with changing and submitting name input of editGoalModal
  handleEditNameChange (event) {
    const goal = { ...this.state.goalBeingEdited, name: event.target.value };
    this.setState({ goalBeingEdited: goal });
  }
//function to deal with changing and submitting minutes input of editGoalModal
  handleEditMinutesChange (event) {
    const goal = { ...this.state.goalBeingEdited, minutes: event.target.value };
    this.setState({ goalBeingEdited: goal });
  }

  //function to deal with adding name input of newGoalModal
  handleNewNameChange (event) {
    const goal = { ...this.state.newGoal, name: event.target.value };
    this.setState({ newGoal: goal });
  }

//function to deal with adding minutes input of newGoalModal
  handleNewMinutesChange (event) {
    const goal = { ...this.state.newGoal, minutes: event.target.value };
    this.setState({ newGoal: goal });
  }

  //function that handles the submit of the new goal from newGoalModal
  handleNewSubmit (event) {
    event.preventDefault();
    //on submit, call AJAX post to API
    const newGoal = this.state.newGoal;
    this.postNewGoals(newGoal);
  }

  //function that handles the submit of the edited goal from editGoalModal
  handleEditSubmit (event) {
    event.preventDefault();
    //on submit, call AJAX post to API
    const editedGoalId = this.state.goalBeingEdited.id;
    this.postEditedGoals(editedGoalId);
  }

 //this gets called on confirm of DeleteGoalModal
  handleDeleteSubmit (event) {
    event.preventDefault();
    const deletedGoalId = this.state.goalBeingEdited.id;
    let tempGoals = this.state.goals;
    tempGoals = tempGoals.filter(
      (goal) => {
        if (goal.id === deletedGoalId) {
          return false;
        } else {
          return true;
        }
      }
    );
    this.setState({ goals: tempGoals });
    this.postRemovedGoals(deletedGoalId);
  }

  //AJAX REQUESTS
  //Ajax post to API when goal is checked, this func is called
  //by setGoalAsDone func
  postCheckedGoals (goalIndex) {
    $.ajax({
      url:`/api/v1/goals/${goalIndex}`,
      headers: {
          'Authorization': apiKeys.GoalsApp,
          Accept : 'application/html'
      },
      method: 'POST',
      data: { done: true },
      success: function (goal) {
        this.getGoals();
      }.bind(this),
      error: function () {
      }
    });
  }

  // //Ajax delete to API when delete button clicked, this func is called
  //by setGoalDeleted func
  postRemovedGoals (deletedGoalId) {
    $.ajax({
      url: `/api/v1/goals/${deletedGoalId}`,
      headers: {
        'Authorization': apiKeys.GoalsApp,
        Accept : 'application/json'
      },
      method: 'DELETE',
      success: function (goal) {
        this.closeModal();
      }.bind(this),
      error: function () {
      }
    });
  }
   //Ajax POST to API when submit button of editGoalModal clicked, this func is called
  //by handleSubmit func. If successful, this function then calls getGoals and closeModal.
  postEditedGoals (editedGoalId) {
    $.ajax({
      url: `/api/v1/goals/${editedGoalId}`,
      headers: {
        'Authorization': apiKeys.GoalsApp,
        Accept : 'application/json'
       },
      data: { goal: this.state.goalBeingEdited },
      method: 'PATCH',
      success: function (goal) {
        this.getGoals();
        this.closeModal();
      }.bind(this),
      error: function () {
      }
    });
  }

//we use AJAX get to get initial goals on page
  getGoals () {
    $.ajax({
      url: `/api/v1/goals`,
      headers: {
        'Authorization': apiKeys.GoalsApp,
        Accept : 'application/json'
      },
      success: function (goals) {
        this.setState({ goals: goals });
      }.bind(this)
    });
  }

 //if a new goal is created, we then want to post and show all of the Goals again.
  postNewGoals (newGoal) {
    $.ajax({
      url: `/api/v1/goals`,
      headers: {
        'Authorization': apiKeys.GoalsApp,
        Accept : 'application/json'
       },
      data: { goal: newGoal },
      method: 'POST',
      success: function (response) {
        this.getGoals();
        this.closeModal();
      }.bind(this),
      error: function () {
      }
    });
  }

  render() {
    return (
      <MuiThemeProvider>
            <div className="container-fluid">
              <AppBar
                title="Full Circle"
                iconClassNameRight="muidocs-icon-navigation-expand-more"/>
              <div className="row">
                <div className="col-xs-12 col-md-7 col-lg-6">
               <GoalList
                 goals={this.state.goals}
                 checkFunction={this.setGoalAsDone}
                 deleteFunction={this.setGoalDeleted}
                 editGoalModalFunction={this.openEditModal}
                 openDeleteModalFunction={this.openDeleteModal}/>
                 <FloatingActionButton
                   className ="fab"
                   onClick={this.openModal}
                   style={{ marginRight: '20' }}>
                  <ContentAdd />
                 </FloatingActionButton>
              </div>
                <div className="GoalDoughnutChart col-xs-12 col-md-5 col-lg-6" style={{ height: '80vh' }}>
                 <h2>Time Spent on Goals</h2>
                 <GoalDoughnutChart goals={this.state.goals} />
              </div>
            </div>
                <NewGoalModal
                  newGoal={this.state.newGoal}
                  isOpen={this.state.newModalIsOpen}
                  onAfterOpen={this.afterOpenModal}
                  onRequestClose={this.closeModal}
                  onNameChange={this.handleNewNameChange}
                  onMinutesChange={this.handleNewMinutesChange}
                  onSubmit={this.handleNewSubmit} />
             <EditGoalModal
               goalBeingEdited={this.state.goalBeingEdited}
               isOpen={this.state.editModalIsOpen}
               onAfterOpen={this.afterOpenModal}
              onRequestClose={this.closeModal}
              onNameChange={this.handleEditNameChange}
              onMinutesChange={this.handleEditMinutesChange}
              onSubmit={this.handleEditSubmit} />
            <DeleteGoalModal
              goalBeingEdited={this.state.goalBeingEdited}
              isOpen={this.state.deleteModalIsOpen}
              onAfterOpen={this.afterOpenModal}
             onRequestClose={this.closeModal}
             onSubmit={this.handleDeleteSubmit} />
          </div>
        </MuiThemeProvider>
    );
  }
}

injectTapEventPlugin();
export default App;
