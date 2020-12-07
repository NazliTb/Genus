package com.esprit.genus;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;

public class GamescreenActivity extends AppCompatActivity {

    String idGame="";

    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        setContentView(R.layout.gamescreen_layout);
        Intent intent = getIntent();
        if (intent != null) {

            if (intent.hasExtra("idGame")) {
                idGame = intent.getStringExtra("idGame");
            }


        }
    }
}