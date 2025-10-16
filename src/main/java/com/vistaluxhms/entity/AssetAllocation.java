package com.vistaluxhms.entity;
import org.jetbrains.annotations.NotNull;

import javax.persistence.*;
import java.util.*;

@Entity
@Table(name = "asset_allocations")
public class AssetAllocation  {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "allocation_id")
    private int allocationId;

    @ManyToOne(fetch = FetchType.EAGER)
    @JoinColumn(name = "asset_id")
    private AssetEntity asset;

    @ManyToOne(fetch =FetchType.EAGER )
    @JoinColumn(name = "ashokateam_id")
    private AshokaTeam ashokaTeam;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "allocated_date")
    private Date allocatedDate;



    public int getAllocationId() {
        return allocationId;
    }

    public void setAllocationId(int allocationId) {
        this.allocationId = allocationId;
    }

    public AssetEntity getAsset() {
        return asset;
    }

    public void setAsset(AssetEntity asset) {
        this.asset = asset;
    }

    public AshokaTeam getAshokaTeam() {
        return ashokaTeam;
    }

    public void setAshokaTeam(AshokaTeam ashokaTeam) {
        this.ashokaTeam = ashokaTeam;
    }

    public Date getAllocatedDate() {
        return allocatedDate;
    }

    public void setAllocatedDate(Date allocatedDate) {
        this.allocatedDate = allocatedDate;
    }


    public void forEach(Object o) {
    }

    public int size() {
        return 0;
    }

    public boolean isEmpty() {
        return false;
    }

    public boolean contains(Object o) {
        return false;
    }

    @NotNull
    public Iterator<AssetAllocation> iterator() {
        return null;
    }

    @NotNull
    public Object[] toArray() {
        return new Object[0];
    }

    @NotNull
    public <T> T[] toArray(@NotNull T[] a) {
        return null;
    }

    public boolean add(AssetAllocation assetAllocation) {
        return false;
    }

    public boolean remove(Object o) {
        return false;
    }

    public boolean containsAll(@NotNull Collection<?> c) {
        return false;
    }

    public boolean addAll(@NotNull Collection<? extends AssetAllocation> c) {
        return false;
    }

    public boolean addAll(int index, @NotNull Collection<? extends AssetAllocation> c) {
        return false;
    }

    public boolean removeAll(@NotNull Collection<?> c) {
        return false;
    }

    public boolean retainAll(@NotNull Collection<?> c) {
        return false;
    }

    public void clear() {

    }

    public AssetAllocation get(int index) {
        return null;
    }

    public AssetAllocation set(int index, AssetAllocation element) {
        return null;
    }

    public void add(int index, AssetAllocation element) {

    }

    public AssetAllocation remove(int index) {
        return null;
    }

    public int indexOf(Object o) {
        return 0;
    }

    public int lastIndexOf(Object o) {
        return 0;
    }

    @NotNull
    public ListIterator<AssetAllocation> listIterator() {
        return null;
    }

    @NotNull
    public ListIterator<AssetAllocation> listIterator(int index) {
        return null;
    }

    @NotNull
    public List<AssetAllocation> subList(int fromIndex, int toIndex) {
        return Arrays.asList();
    }

    public void setOwnerId(Integer assetOwnerId) {
    }
}
