package com.esprit.genus;

import androidx.appcompat.app.AppCompatActivity;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

import com.esprit.genus.Retrofit.INodeJS;
import com.esprit.genus.Retrofit.RetrofitClient;
import com.google.android.material.textfield.TextInputEditText;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.CompositeDisposable;
import io.reactivex.functions.Consumer;
import io.reactivex.schedulers.Schedulers;
import retrofit2.Retrofit;

public class LoginActivity extends AppCompatActivity {

    INodeJS myAPI;
    CompositeDisposable compositeDisposable=new CompositeDisposable();
    TextInputEditText username;
    TextInputEditText password;
    Button login_button;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.login_layout);

        //Init API
        Retrofit retrofit= RetrofitClient.getInstance();
        myAPI=retrofit.create((INodeJS.class));

        //View
        login_button=(Button)findViewById(R.id.login_button);

        username=(TextInputEditText)findViewById(R.id.username);
        password=(TextInputEditText)findViewById(R.id.password);

        //Event
        login_button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                loginUser(username.getText().toString(),password.getText()
                .toString());
            }
        });


    }

    private void loginUser(String username, String password) {
        compositeDisposable.add(myAPI.loginUser(username,password)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(new Consumer<String>() {
                    @Override
                    public void accept(String s) throws Exception {
                    if(s.contains("password"))
                        /*pass to the next activity for now we'll make
                        a toast appear to test */
                        Toast.makeText(LoginActivity.this, "Login Successful", Toast.LENGTH_SHORT).show();
                        else
                        Toast.makeText(LoginActivity.this, ""+s, Toast.LENGTH_SHORT).show();
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