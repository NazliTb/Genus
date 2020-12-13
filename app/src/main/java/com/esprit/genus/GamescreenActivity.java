package com.esprit.genus;

import android.content.Intent;
import android.os.Bundle;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;
import androidx.recyclerview.widget.DividerItemDecoration;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.bumptech.glide.Glide;
import com.esprit.genus.Adapter.CommentAdapter;
import com.esprit.genus.Model.Comment;
import com.esprit.genus.Model.Game;
import com.esprit.genus.Retrofit.INodeJS;
import com.esprit.genus.Retrofit.RetrofitClient;
import com.jgabrielfreitas.core.BlurImageView;

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

public class GamescreenActivity extends AppCompatActivity {

    INodeJS myAPI, myAPI1;
    CompositeDisposable compositeDisposable = new CompositeDisposable();

    private int idGame, idUser;
    private ImageView gameImg;
    BlurImageView gameBg;
    private TextView gameName, studioName, favNbr, cmtNbr, gameDesc;
    private Button addGame, addWishlist, addFav;

    RecyclerView recycler_comments;
    LinearLayoutManager layoutManager;
    CommentAdapter adapter;


    @Override
    protected void onCreate(Bundle savedInstanceState) {

        super.onCreate(savedInstanceState);
        setContentView(R.layout.gamescreen_layout);

        //Get gameId
        Intent intent = getIntent();
        if (intent != null) {

            if (intent.hasExtra("idGame")) {
                idGame = Integer.parseInt(intent.getStringExtra("idGame"));
            }
        }

        //Get userId
        Intent intent2 = getIntent();
        if (intent2 != null) {
            if (intent2.hasExtra("idUser")) {
                idUser = Integer.parseInt(intent2.getStringExtra("idUser"));
            }
        }

        //verify that we got the game ID
        //Toast.makeText(this, "idGame: " + idGame, Toast.LENGTH_SHORT).show();

        //Init API
        Retrofit retrofit = RetrofitClient.getInstance();
        myAPI = retrofit.create((INodeJS.class));

        Retrofit retrofit1 = new Retrofit.Builder()
                .baseUrl("http://10.0.2.2:3000/")
                .addConverterFactory(GsonConverterFactory.create())
                .build();
        myAPI1 = retrofit1.create((INodeJS.class));
        final Call <List<Game>> myGame = myAPI1.GetGameDetails(idGame);
        final Call <List<Comment>> listComments = myAPI1.GetComments(idGame);

        //our views
        gameImg = (ImageView) findViewById(R.id.gameImg);
        gameBg = (BlurImageView) findViewById(R.id.gameBg);
        gameName = (TextView) findViewById(R.id.gameName);
        studioName = (TextView) findViewById(R.id.gameStudio);
        favNbr = (TextView) findViewById(R.id.favCount);
        cmtNbr = (TextView) findViewById(R.id.cmCount);
        gameDesc = (TextView) findViewById(R.id.gameDesc);

        //view for the comment section
        recycler_comments = (RecyclerView) findViewById(R.id.recyclerViewComments);
        recycler_comments.setHasFixedSize(true);
        layoutManager = new LinearLayoutManager(this);
        recycler_comments.setLayoutManager(layoutManager);
        recycler_comments.addItemDecoration(new DividerItemDecoration(this,layoutManager.getOrientation()));

        //our buttons
        addGame = (Button) findViewById(R.id.addButton);
        addWishlist = (Button) findViewById(R.id.addWishlist);
        addFav = (Button) findViewById(R.id.addFavorite);

        //add to the gamelist

        //add to wishlist

        //add to favlist

        //display our game informations
        myGame.enqueue(new Callback <List<Game>>() {
            @Override
            public void onResponse(Call <List<Game>> call, Response <List<Game>> response) {
                if (!response.isSuccessful()) {
                    return;
                }
                List<Game> gameDetails = response.body();
                int cpt=0;
                for (Game g:gameDetails) {
                    gameName.setText(g.getName());
                    studioName.setText("by "+g.getCompanyName());
                    gameDesc.setText(g.getDescription());
                    Glide.with(GamescreenActivity.this)
                            .load("http://10.0.2.2:3000/image/"+g.getGamePicture())
                            .into(gameImg);
                    Glide.with(GamescreenActivity.this)
                            .load("http://10.0.2.2:3000/image/"+g.getGamePicture())
                            .into(gameBg);
                }
            }

            @Override
            public void onFailure(Call <List<Game>> call, Throwable t) {
                Toast.makeText(GamescreenActivity.this, "Not found" , Toast.LENGTH_SHORT).show();
            }
        });

        //display our comment section
        listComments.enqueue(new Callback<List<Comment>>() {
            @Override
            public void onResponse(Call<List<Comment>> call, Response<List<Comment>> response) {
                if (!response.isSuccessful()) {
                    return;
                }
                List <Comment> comments = response.body();
                adapter = new CommentAdapter(GamescreenActivity.this, comments);
                recycler_comments.setAdapter(adapter);
            }

            @Override
            public void onFailure(Call<List<Comment>> call, Throwable t) {
                Toast.makeText(GamescreenActivity.this, "Not found", Toast.LENGTH_SHORT).show();
            }
        });

    }

    private void addToGameList(int idUser, int idGame){
        final String[] idGameList = {""};
        final String[] userId = {""};
        final String[] gameId = {""};

        compositeDisposable.add(myAPI.AddToGameList(idUser, idGame)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(new Consumer<String>() {
                    @Override
                    public void accept(String s) throws Exception {

                    }
                })
        );
    }

    private void addToWishList(int idUser, int idGame){
        final String[] idWishList = {""};
        final String[] userId = {""};
        final String[] gameId = {""};

        compositeDisposable.add(myAPI.AddToGameList(idUser, idGame)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(new Consumer<String>() {
                    @Override
                    public void accept(String s) throws Exception {

                    }
                })
        );
    }

    private void addToFavList(int idUser, int idGame){
        final String[] idFav = {""};
        final String[] userId = {""};
        final String[] gameId = {""};

        compositeDisposable.add(myAPI.AddToGameList(idUser, idGame)
                .subscribeOn(Schedulers.io())
                .observeOn(AndroidSchedulers.mainThread())
                .subscribe(new Consumer<String>() {
                    @Override
                    public void accept(String s) throws Exception {

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