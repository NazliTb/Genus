package com.esprit.genus;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.util.DisplayMetrics;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import androidx.annotation.Nullable;

import com.esprit.genus.Retrofit.INodeJS;
import com.esprit.genus.Retrofit.RetrofitClient;

import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.CompositeDisposable;
import io.reactivex.functions.Consumer;
import io.reactivex.schedulers.Schedulers;
import retrofit2.Retrofit;

public class PopupActivity extends Activity {
    //PopupWindow display method
    INodeJS myAPI;
    CompositeDisposable compositeDisposable = new CompositeDisposable();
    EditText username;
    EditText password;
    EditText cPassword;
    Button updateProfile;
    public String idUser;

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        setContentView(R.layout.popupwindow_layout);

        DisplayMetrics dm=new DisplayMetrics();
        getWindowManager().getDefaultDisplay().getMetrics(dm);
        int width=dm.widthPixels;
        int height=dm.heightPixels;
        getWindow().setLayout((int)(width*.8),(int)(height*.8));
        //Recuperer les données de homepage
        Intent intent = getIntent();
        if (intent != null) {

            if (intent.hasExtra("idUser")) {
                idUser = intent.getStringExtra("idUser");
            }
        }
        //Init API
        Retrofit retrofit = RetrofitClient.getInstance();
        myAPI = retrofit.create((INodeJS.class));

        username = (EditText) findViewById(R.id.editusername);
        password = (EditText) findViewById(R.id.editpassword);
        cPassword = (EditText) findViewById(R.id.editcpassword);

        updateProfile = findViewById(R.id.updateProfile_button);
        updateProfile.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                updateUser(idUser,username.getText().toString(), password.getText()
                        .toString());


            }
        });
    }

    private void updateUser(String idUser,String username, String password) {


        compositeDisposable.add(myAPI.editProfile(Integer.parseInt(idUser),username, password,"")
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(new Consumer<String>() {
                    @Override
                    public void accept(String s) throws Exception {
                        Toast.makeText(PopupActivity.this, "" + s, Toast.LENGTH_SHORT).show();
                    }


                }));

    }
}
