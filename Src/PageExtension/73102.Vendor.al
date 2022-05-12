pageextension 73102 "DG Vend  Ext" extends "Vendor List"
{
    actions
    {
        addafter("Bank Accounts")
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
                    SourceVend: Record Vendor;
                    TargetVend: Record Vendor;
                begin
                    if repcompany.FindSet() then
                        repeat
                            if SourceVend.FindFirst() then
                                repeat
                                    TargetVend.Reset();
                                    TargetVend.ChangeCompany(repcompany."To Company");
                                    if not TargetVend.Get(SourceVend."No.") then begin
                                        if repcompany.Enable then begin
                                            TargetVend.Init();
                                            TargetVend.Copy(SourceVend);
                                            TargetVend.Insert();
                                        end;
                                    end;
                                until SourceVend.Next = 0;
                        until repcompany.Next = 0;
                end;
            }
        }
    }
}