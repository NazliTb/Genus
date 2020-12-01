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
    private TextView gameList, wishList, signOut;



    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.profile_layout);

        gameList = (TextView) findViewById(R.id.games);
        wishList = (TextView) findViewById(R.id.wishList);
        signOut = (TextView) findViewById(R.id.signout);

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