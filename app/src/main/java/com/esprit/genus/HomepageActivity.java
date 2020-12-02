package com.esprit.genus;

import androidx.appcompat.app.AppCompatActivity;
import androidx.fragment.app.Fragment;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.ImageView;
import android.widget.RelativeLayout;
import android.widget.TextView;
import android.widget.Toast;

import com.esprit.genus.Retrofit.INodeJS;
import com.esprit.genus.Retrofit.RetrofitClient;

import io.reactivex.Observer;
import io.reactivex.android.schedulers.AndroidSchedulers;
import io.reactivex.disposables.CompositeDisposable;
import io.reactivex.functions.Consumer;
import io.reactivex.schedulers.Schedulers;
import retrofit2.Retrofit;

public class HomepageActivity extends AppCompatActivity {
    private ImageView profileIcon, libIcon, loopIcon, heartIcon, chatIcon;
    private TextView profileTitle, libTitle, loopTitle, heartTitle, chatTitle;
    public Fragment selectedFragment = null;
    private RelativeLayout rl;
    INodeJS myAPI;
    private String idUser = "";
    private String username="";
    CompositeDisposable compositeDisposable = new CompositeDisposable();


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.homepage_layout);
        //Recuperer les données envoyé par login fil oncreate
        Intent intent = getIntent();
        if (intent != null){

            if (intent.hasExtra("idUser")){
                idUser = intent.getStringExtra("idUser");
            }
            if (intent.hasExtra("username")){
                username = intent.getStringExtra("username");
            }

        }



        //Init API
        Retrofit retrofit = RetrofitClient.getInstance();
        myAPI = retrofit.create((INodeJS.class));

        rl = (RelativeLayout) findViewById(R.id.relativeLayout);

        profileIcon = (ImageView) findViewById(R.id.userIcon);
        profileTitle = (TextView) findViewById(R.id.profile);
        libIcon = (ImageView) findViewById(R.id.libIcon);
        libTitle = (TextView) findViewById(R.id.lib);
        loopIcon = (ImageView) findViewById(R.id.loopIcon);
        loopTitle = (TextView) findViewById(R.id.loop);
        heartIcon = (ImageView) findViewById(R.id.heartIcon);
        heartTitle = (TextView) findViewById(R.id.wishlist);
        chatIcon = (ImageView) findViewById(R.id.chatIcon);
        chatTitle = (TextView) findViewById(R.id.chat);

        //getSupportFragmentManager().beginTransaction().replace(R.id.fragmentContainer, new GamelistActivity()).commit();
        loopIcon.setImageResource(R.drawable.loop);
        loopTitle.setTextColor(getResources().getColor(R.color.colorPrimary));

        profileIcon.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Intent intent = new Intent(HomepageActivity.this, ProfileActivity.class);
                intent.putExtra("idUser",idUser);
                intent.putExtra("username",username);
                GetGamesNbr(idUser);
                System.out.println(intent.getStringExtra("gameNbr"));
                GetFavouriteGamesNbr(idUser);
                GetWishGamesNbr(idUser);
                HomepageActivity.this.startActivity(intent);

                //Fragments navigation coloring
                profileIcon.setImageResource(R.drawable.user3);
                profileTitle.setTextColor(getResources().getColor(R.color.colorPrimary));

                loopIcon.setImageResource(R.drawable.loop2);
                loopTitle.setTextColor(getResources().getColor(R.color.hintColor));
                libIcon.setImageResource(R.drawable.library2);
                libTitle.setTextColor(getResources().getColor(R.color.hintColor));
                heartIcon.setImageResource(R.drawable.heart2);
                heartTitle.setTextColor(getResources().getColor(R.color.hintColor));
                chatIcon.setImageResource(R.drawable.chat2);
                chatTitle.setTextColor(getResources().getColor(R.color.hintColor));

                //Fragment display

            }
        });

        libIcon.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //Fragments navigation coloring
                libIcon.setImageResource(R.drawable.library);
                libTitle.setTextColor(getResources().getColor(R.color.colorPrimary));

                profileIcon.setImageResource(R.drawable.user2);
                profileTitle.setTextColor(getResources().getColor(R.color.hintColor));
                loopIcon.setImageResource(R.drawable.loop2);
                loopTitle.setTextColor(getResources().getColor(R.color.hintColor));
                heartIcon.setImageResource(R.drawable.heart2);
                heartTitle.setTextColor(getResources().getColor(R.color.hintColor));
                chatIcon.setImageResource(R.drawable.chat2);
                chatTitle.setTextColor(getResources().getColor(R.color.hintColor));

                //Fragment display
                selectedFragment = new GamelistActivity();
                getSupportFragmentManager().beginTransaction().replace(R.id.fragmentContainer, selectedFragment).commit();


            }
        });

        loopIcon.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //Fragments navigation coloring
                loopIcon.setImageResource(R.drawable.loop);
                loopTitle.setTextColor(getResources().getColor(R.color.colorPrimary));

                profileIcon.setImageResource(R.drawable.user2);
                profileTitle.setTextColor(getResources().getColor(R.color.hintColor));
                libIcon.setImageResource(R.drawable.library2);
                libTitle.setTextColor(getResources().getColor(R.color.hintColor));
                heartIcon.setImageResource(R.drawable.heart2);
                heartTitle.setTextColor(getResources().getColor(R.color.hintColor));
                chatIcon.setImageResource(R.drawable.chat2);
                chatTitle.setTextColor(getResources().getColor(R.color.hintColor));
            }
        });

        heartIcon.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //Fragments navigation coloring
                heartIcon.setImageResource(R.drawable.heart);
                heartTitle.setTextColor(getResources().getColor(R.color.colorPrimary));

                profileIcon.setImageResource(R.drawable.user2);
                profileTitle.setTextColor(getResources().getColor(R.color.hintColor));
                libIcon.setImageResource(R.drawable.library2);
                libTitle.setTextColor(getResources().getColor(R.color.hintColor));
                loopIcon.setImageResource(R.drawable.loop2);
                loopTitle.setTextColor(getResources().getColor(R.color.hintColor));
                chatIcon.setImageResource(R.drawable.chat2);
                chatTitle.setTextColor(getResources().getColor(R.color.hintColor));
            }
        });

        chatIcon.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                //Fragments navigation coloring
                chatIcon.setImageResource(R.drawable.chat);
                chatTitle.setTextColor(getResources().getColor(R.color.colorPrimary));

                profileIcon.setImageResource(R.drawable.user2);
                profileTitle.setTextColor(getResources().getColor(R.color.hintColor));
                libIcon.setImageResource(R.drawable.library2);
                libTitle.setTextColor(getResources().getColor(R.color.hintColor));
                heartIcon.setImageResource(R.drawable.heart2);
                heartTitle.setTextColor(getResources().getColor(R.color.hintColor));
                loopIcon.setImageResource(R.drawable.loop2);
                loopTitle.setTextColor(getResources().getColor(R.color.hintColor));
            }
        });

    }

    private void GetGamesNbr(String idUser) {
    compositeDisposable.add(myAPI.getGamesNbr(idUser)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(new Consumer<String>() {
                    @Override
                    public void accept(String s) throws Exception {
                     Intent intent = new Intent(HomepageActivity.this, ProfileActivity.class);
                      //  System.out.println(s);
                        intent.putExtra("gameNbr", s);

                    }


                })
        );

    }

    private void GetFavouriteGamesNbr(String idUser) {
        compositeDisposable.add(myAPI.getFavouriteGamesNbr(idUser)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(new Consumer<String>() {
                    @Override
                    public void accept(String s) throws Exception {
                        Intent intent = new Intent(HomepageActivity.this, ProfileActivity.class);
                        intent.putExtra("favNbr",s);

                    }


                })
        );

    }

    private void GetWishGamesNbr(String idUser) {
        compositeDisposable.add(myAPI.getWishGamesNbr(idUser)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(new Consumer<String>() {
                    @Override
                    public void accept(String s) throws Exception {
                        Intent intent = new Intent(HomepageActivity.this, ProfileActivity.class);
                        intent.putExtra("wishNbr",s);

                    }


                })
        );

    }
    private void DisplayGames(int idUser) {
        compositeDisposable.add(myAPI.GetGameList(idUser)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(new Consumer<String>() {
                    @Override
                    public void accept(String s) throws Exception {
                        for (int i = 0; i <s.length(); i++) {
                        }
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