pageextension 73103 "DG Items  Ext" extends "Item List"
{
    actions
    {
        addafter("&Bin Contents")
        {
            action(Replicate)
            {
                Image = Copy;
                ApplicationArea = all;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                PromotedOnly = true;
                trigger OnAction()
                var
                    Repcompany: Record Replication;
                    SourceItem: Record Item;
                    TargetItem: Record Item;
                begin
                    if repcompany.FindSet() then
                        repeat
                            if SourceItem.FindFirst() then
                                repeat
                                    TargetItem.Reset();
                                    TargetItem.ChangeCompany(repcompany."To Company");
                                    if not TargetItem.Get(SourceItem."No.") then begin
                                        if repcompany.Enable then begin
                                            TargetItem.Init();
                                            TargetItem.Copy(SourceItem);
                                            TargetItem.Insert();
                                        end;
                                    end;
                                until SourceItem.Next = 0;
                        until repcompany.Next = 0;
                end;
            }
        }
    }
}