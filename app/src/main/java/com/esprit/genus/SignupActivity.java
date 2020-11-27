package com.esprit.genus;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import com.esprit.genus.Retrofit.INodeJS;
import com.esprit.genus.Retrofit.RetrofitClient;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.CompositeDisposable;
import io.reactivex.functions.Consumer;
import io.reactivex.schedulers.Schedulers;
import retrofit2.Retrofit;

public class SignupActivity extends AppCompatActivity {

    INodeJS myAPI;
    CompositeDisposable compositeDisposable=new CompositeDisposable();
    EditText username;
    EditText password;
    EditText email;
    EditText confirmPassword;
    TextView log_in;
    Button signup_button;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.signup_layout);

        //Init API
        Retrofit retrofit= RetrofitClient.getInstance();
        myAPI=retrofit.create((INodeJS.class));

        //View
        signup_button=(Button)findViewById(R.id.signup_button);

        username=(EditText)findViewById(R.id.username);
        password=(EditText)findViewById(R.id.password);
        email=(EditText)findViewById(R.id.email);
        confirmPassword=(EditText) findViewById(R.id.cPassword);
        log_in=(TextView)findViewById(R.id.log_in);

        //Event
        signup_button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                registerUser(email.getText().toString(),username.getText().toString(),password.getText()
                        .toString());
            }
        });

        log_in.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(SignupActivity.this, LoginActivity.class);
                SignupActivity.this.startActivity(intent);
            }
        });

    }

    private void registerUser(String email,String username, String password) {
        compositeDisposable.add(myAPI.registerUser(email,username,password)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(new Consumer<String>() {
                    @Override
                    public void accept(String s) throws Exception {
                        if(s.contains("password"))
                        /*pass to the next activity for now we'll make
                        a toast appear to test */
                            Toast.makeText(SignupActivity.this, "Register Successful", Toast.LENGTH_SHORT).show();
                        else
                            Toast.makeText(SignupActivity.this, ""+s, Toast.LENGTH_SHORT).show();
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