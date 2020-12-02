package com.esprit.genus;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.esprit.genus.Retrofit.INodeJS;
import com.esprit.genus.Retrofit.RetrofitClient;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.CompositeDisposable;
import io.reactivex.functions.Consumer;
import io.reactivex.schedulers.Schedulers;
import retrofit2.Retrofit;

public class LoginActivity extends AppCompatActivity {

    INodeJS myAPI;
    CompositeDisposable compositeDisposable = new CompositeDisposable();
    EditText username;
    EditText password;
    Button login_button;
    TextView sign_up;
    TextView forgottenpassword;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.login_layout);
        //getSupportActionBar().hide();

        //Init API
        Retrofit retrofit = RetrofitClient.getInstance();
        myAPI = retrofit.create((INodeJS.class));

        //View
        login_button = (Button) findViewById(R.id.login_button);

        username = (EditText) findViewById(R.id.username);
        password = (EditText) findViewById(R.id.password);

        sign_up = (TextView) findViewById(R.id.sign_up);

        forgottenpassword = (TextView) findViewById(R.id.forgotten_password);

        //Event
        login_button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if (username.getText().toString().equals("")||
                        password.getText().toString().equals(""))
                {
                    Toast.makeText(LoginActivity.this, "Please fill in all fields", Toast.LENGTH_SHORT).show();

                }
                else if(!username.getText().toString().contains("@"))
                {
                    Toast.makeText(LoginActivity.this, "Please give a correct email", Toast.LENGTH_SHORT).show();
                }
                else {
                    loginUser(username.getText().toString(), password.getText()
                            .toString());
                }
            }
        });

        sign_up.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(LoginActivity.this, SignupActivity.class);
                LoginActivity.this.startActivity(intent);
            }
        });

        forgottenpassword.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(LoginActivity.this, ForgottenpasswordActivity.class);
                LoginActivity.this.startActivity(intent);
            }
        });

    }

    private void loginUser(String username, String password) {
        final String[] idUser = {""};
        final String[] userName = {""};

        compositeDisposable.add(myAPI.loginUser(username, password)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(new Consumer<String>() {
                    @Override
                    public void accept(String s) throws Exception {
                        int positionDebidUser;
                        int positionFinidUser;
                        int positionDebUsername;
                        int positionFinUsername;
                        if (s.contains("username")) {
                        /*pass to the next activity for now we'll make
                        a toast appear to test */
                            //Toast.makeText(LoginActivity.this, "Login Successful", Toast.LENGTH_SHORT).show();
                            positionDebidUser = s.indexOf("idUser") + 8;
                            positionFinidUser = s.indexOf(",");
                            positionDebUsername= s.indexOf("username") +11;
                            positionFinUsername= s.indexOf(",",positionDebUsername)-1;

                            idUser[0] = s.substring(positionDebidUser, positionFinidUser);
                            userName[0] = s.substring(positionDebUsername, positionFinUsername);

                            Toast.makeText(LoginActivity.this, "Login Successful", Toast.LENGTH_SHORT).show();
                            Intent intent = new Intent(LoginActivity.this, HomepageActivity.class);
                            intent.putExtra("idUser",idUser[0]);
                            intent.putExtra("username",userName[0]);
                            LoginActivity.this.startActivity(intent);
                        }
                        else
                            Toast.makeText(LoginActivity.this, "" + s, Toast.LENGTH_SHORT).show();
                    }

                })
        );

    }

    @Override
    protected void onStop() {
        compositeDisposable.clear();
        super.onStop();

    }

    @Override
    protected void onDestroy() {
        compositeDisposable.clear();
        super.onDestroy();
    }
}