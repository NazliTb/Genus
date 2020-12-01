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

public class ProfileActivity extends Fragment {
    private TextView gameList, wishList;
    public Fragment selectedFragment = null;


    @Nullable
    @Override
    public View onCreateView(@NonNull LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        gameList = (TextView) getView().findViewById(R.id.games);
        wishList = (TextView) getView().findViewById(R.id.wishList);

        gameList.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                selectedFragment = new GamelistActivity();
                getActivity().getSupportFragmentManager().beginTransaction().replace(R.id.fragmentContainer, selectedFragment).commit();

            }
        });

        return inflater.inflate(R.layout.profile_layout, container, false);
    }

    /*@Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.profile_layout);

        gameList = (TextView) findViewById(R.id.games);
        wishList = (TextView) findViewById(R.id.wishList);


        gameList.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(ProfileActivity.this, GamelistActivity.class);
                ProfileActivity.this.startActivity(intent);

            }
        });
    }*/
}