package com.esprit.genus;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;

import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import com.esprit.genus.Model.Game;
import com.esprit.genus.Retrofit.INodeJS;
import com.esprit.genus.Retrofit.RetrofitClient;

import java.util.List;


import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.CompositeDisposable;
import io.reactivex.functions.Consumer;
import io.reactivex.schedulers.Schedulers;
import retrofit2.Call;
import retrofit2.Callback;
import retrofit2.Response;
import retrofit2.Retrofit;
import retrofit2.converter.gson.GsonConverterFactory;

public class ProfileActivity extends AppCompatActivity {
    private TextView gameList, wishList, signOut,gamesNbr,favNbr,wishesNbr,username;
    private String idUser="";
    CompositeDisposable compositeDisposable = new CompositeDisposable();
    private Button editProfile;
    INodeJS myAPI;
    INodeJS myAPI1;
    AlertDialog dialog;
    AlertDialog.Builder builder;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.profile_layout);

        gameList = (TextView) findViewById(R.id.games);
        wishList = (TextView) findViewById(R.id.wishList);
        signOut = (TextView) findViewById(R.id.signout);
        gamesNbr = (TextView) findViewById(R.id.gamesNbr);
        favNbr = (TextView) findViewById(R.id.favNbr);
        wishesNbr = (TextView) findViewById(R.id.wishesNbr);
        username = (TextView) findViewById(R.id.username);
        editProfile=(Button) findViewById(R.id.editProfile);
        //Recuperer les données de homepage
        Intent intent = getIntent();
        if (intent != null) {

            if (intent.hasExtra("idUser")) {
                idUser = intent.getStringExtra("idUser");
            }
            if (intent.hasExtra("username")) {
                username.setText(intent.getStringExtra("username"));
            }


        }
        //Init API
        Retrofit retrofit = RetrofitClient.getInstance();

        //this one i used for the gamenumber , wishnumber , favnumber  because i'm using Gson okay ?
        Retrofit retrofit1 = new Retrofit.Builder().baseUrl("http://10.0.2.2:3000/")
                .addConverterFactory(GsonConverterFactory.create())
                .build();
        myAPI1 = retrofit.create((INodeJS.class));
        myAPI = retrofit1.create((INodeJS.class));

        Call<List<Game>> listWishGames = myAPI.GetWishList(Integer.parseInt(idUser));
        Call<List<Game>> listFavGames = myAPI.GetFavList(Integer.parseInt(idUser));
        Call<List<Game>> listGames = myAPI.GetGameListForNumber(Integer.parseInt(idUser));
        listGames.enqueue(new Callback<List<Game>>() {
            @Override
            public void onResponse(Call<List<Game>> call, Response<List<Game>> response) {
                if (!response.isSuccessful()) {

                    return;
                }
                List<Game> Games = response.body();
                int cpt=0;
                for(Game g:Games)
                {

                    cpt++;
                }
                gamesNbr.setText(cpt+"");
            }

            @Override
            public void onFailure(Call<List<Game>> call, Throwable t) {

            }
        });


        listFavGames.enqueue(new Callback<List<Game>>() {
            @Override
            public void onResponse(Call<List<Game>> call, Response<List<Game>> response) {
                if (!response.isSuccessful()) {

                    return;
                }
                List<Game> FavGames = response.body();
                int cpt=0;
                for(Game g:FavGames)
                {

                    cpt++;
                }
                favNbr.setText(cpt+"");
            }

            @Override
            public void onFailure(Call<List<Game>> call, Throwable t) {

            }
        });

        listWishGames.enqueue(new Callback<List<Game>>() {
            @Override
            public void onResponse(Call<List<Game>> call, Response<List<Game>> response) {
                if (!response.isSuccessful()) {

                    return;
                }
                List<Game> wishGames = response.body();
                int cpt=0;
                for(Game g:wishGames)
                {
                 
                    cpt++;
                }
                wishesNbr.setText(cpt+"");



            }

            @Override
            public void onFailure(Call<List<Game>> call, Throwable t) {

            }
        });


        gameList.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                /*Intent intent = new Intent(ProfileActivity.this, GamelistActivity.class);
                ProfileActivity.this.startActivity(intent);*/

            }
        });

        signOut.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(ProfileActivity.this, LoginActivity.class);
                ProfileActivity.this.startActivity(intent);
            }
        });

        editProfile.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
              /* Intent intent = new Intent(ProfileActivity.this, PopupActivity.class);
                intent.putExtra("idUser",idUser);
                ProfileActivity.this.startActivity(intent);*/
                View vpop=getLayoutInflater().inflate(R.layout.popupwindow_layout,null);
                final EditText username;
                final EditText password;
                final EditText cPassword;
                Button updateProfile;
                username = (EditText) vpop.findViewById(R.id.editusername);
                password = (EditText) vpop.findViewById(R.id.editpassword);
                cPassword = (EditText) vpop.findViewById(R.id.editcpassword);

                updateProfile = vpop.findViewById(R.id.updateProfile_button);
                updateProfile.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View v) {
                        if (username.getText().toString().equals("")||
                                password.getText().toString().equals("")||
                                cPassword.getText().toString().equals(("")))
                        {
                            Toast.makeText(ProfileActivity.this, "Please fill in all fields", Toast.LENGTH_SHORT).show();
                        }
                        else if(!password.getText().toString().equals(cPassword.getText().toString()))
                        {
                            Toast.makeText(ProfileActivity.this, "the two password fields should be same", Toast.LENGTH_SHORT).show();
                        }
                        else {
                            updateUser(idUser, username.getText().toString(), password.getText()
                                    .toString());

                        }

                    }
                });

              builder=new AlertDialog.Builder(ProfileActivity.this);
              builder.setView(vpop);
              dialog=builder.create();
              dialog.show();
            }
        });

    }

    private void updateUser(String idUser,String username, String password) {


        compositeDisposable.add(myAPI1.editProfile(Integer.parseInt(idUser),username, password,"")
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(new Consumer<String>() {
                    @Override
                    public void accept(String s) throws Exception {
                        Toast.makeText(ProfileActivity.this, "" + s, Toast.LENGTH_SHORT).show();
                    }


                }));

    }
}