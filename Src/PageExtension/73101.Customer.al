pageextension 73101 "DG Cust  Ext" extends "Customer List"
{
    actions
    {
        addafter(Statement)
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
                    SourceCust: Record Customer;
                    TargetCust: Record Customer;
                begin
                    if repcompany.FindSet() then
                        repeat
                            if SourceCust.FindFirst() then
                                repeat
                                    TargetCust.Reset();
                                    TargetCust.ChangeCompany(repcompany."To Company");
                                    if not TargetCust.Get(SourceCust."No.") then begin
                                        if repcompany.Enable then begin
                                            TargetCust.Init();
                                            TargetCust.Copy(SourceCust);
                                            TargetCust.Insert();
                                        end;
                                    end;
                                until SourceCust.Next = 0;
                        until repcompany.Next = 0;
                end;
            }
        }
    }
}