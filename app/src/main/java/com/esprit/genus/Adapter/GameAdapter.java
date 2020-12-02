package com.esprit.genus.Adapter;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.cardview.widget.CardView;
import androidx.recyclerview.widget.RecyclerView;

import com.esprit.genus.Model.Game;
import com.esprit.genus.R;

import java.util.List;

public class GameAdapter extends RecyclerView.Adapter<GameAdapter.MyViewHolder> {

    List<Game> gameList;

    public GameAdapter(List<Game> gameList) {
        this.gameList = gameList;
    }

    @NonNull
    @Override
    public MyViewHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        View itemView = LayoutInflater.from(parent.getContext()).inflate(R.layout.game_layout, parent, false);
        return null;
    }

    @Override
    public void onBindViewHolder(@NonNull MyViewHolder holder, int position) {

    }

    @Override
    public int getItemCount() {
        return gameList.size();
    }

    public class MyViewHolder extends RecyclerView.ViewHolder{

        CardView root_view;
        TextView gameName, gameStudio, gameType, gameDate;

        public MyViewHolder(@NonNull View itemView) {
            super(itemView);

            root_view = (CardView)itemView.findViewById(R.id.root_view);
            gameName = (TextView)itemView.findViewById(R.id.txt_name);
            gameStudio = (TextView)itemView.findViewById(R.id.txt_companyname);
            gameType = (TextView)itemView.findViewById(R.id.txt_type);
            gameDate = (TextView)itemView.findViewById(R.id.txt_date);

        }
    }
}
