$(document).ready(function() {
    $("#authorized").hide();
    $("#error").hide();
});

function signIngoogle() {
    var provider = new firebase.auth.GoogleAuthProvider();

    firebase.auth().signInWithPopup(provider)
            .then(signInSucceed)
            .catch(signInError);
}

function signInSucceed(result) {
    if (result.credential) {
        googleAccountToken = result.credential.accessToken;
        user = result.user;

        $("#photo").attr("src", user.photoURL);
        $("#displayName").html(user.displayName);
        $("#email").html(user.email);
        $("#refreshToken").html(user.refreshToken);
        $("#uid").html(user.uid);

        $("#authorized").show();
        $("#signIn").hide();

        location.href="view/main.jsp";
    }
}

function signInError(error) {
    var errorCode = error.code;
    var errorMessage = error.message;
    var email = error.email;
    var credential = error.credential;

    var errmsg = errorCode + " " + errorMessage;

    if(typeof(email) != 'undefined') {
        errmsg += "<br />";
        errmsg += "Cannot sign in with your google account: " + email;
    }

    if(typeof(credential) != 'undefined') {
        errmsg += "<br />";
        errmsg += credential;
    }

    lastWork = "signIngoogle";
    alert($("#error #errmsg"));
    $("#error").show();
    $("#signIn").hide();
    return;
}

function back() {
    $("#" + lastWork).show();
    $("#error").hide();
}
