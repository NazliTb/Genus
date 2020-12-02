package com.esprit.genus;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;

import android.content.Intent;
import android.os.Bundle;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

public class ProfileActivity extends AppCompatActivity {
    private TextView gameList, wishList, signOut,gamesNbr,favNbr,wishesNbr,username;
    private String idUser="";


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
        username= (TextView) findViewById(R.id.username);
        //Recuperer les données de homepage
        Intent intent = getIntent();
        if (intent != null){

            if (intent.hasExtra("idUser")){
                idUser = intent.getStringExtra("idUser");
            }
            if (intent.hasExtra("username")){
                username.setText(intent.getStringExtra("username"));
            }
            if (intent.hasExtra("gameNbr")){
                gamesNbr.setText(intent.getStringExtra("gameNbr"));
            }
            if (intent.hasExtra("favNbr")){
                favNbr.setText(intent.getStringExtra("favNbr"));
            }
            if (intent.hasExtra("wishNbr")){
                wishesNbr.setText(intent.getStringExtra("wishNbr"));
            }

        }

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

    }
}