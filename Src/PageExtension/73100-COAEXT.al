pageextension 73100 DGCOAEXT extends "Chart of Accounts"
{
    actions
    {
        addafter("Periodic Activities")
        {
            action(Replicate)
            {
                Image = Copy;
                ApplicationArea = all;
                trigger OnAction()
                var
                    Repcompany: Record Replication;
                    SourceCOA: Record "G/L Account";
                    TargetCOA: Record "G/L Account";
                begin
                    if repcompany.FindSet() then
                        repeat
                            if SourceCOA.FindFirst() then
                                repeat
                                    TargetCOA.Reset();
                                    TargetCOA.ChangeCompany(repcompany."To Company");

                                    if not TargetCOA.Get(SourceCOA."No.") then begin
                                        if repcompany.Enable = true then begin
                                            TargetCOA.Init();
                                            TargetCOA.Copy(SourceCOA);
                                            TargetCOA.Insert();
                                        end;
                                    end
                                    else
                                        if Repcompany.Enable then begin
                                            if TargetCOA.Get(SourceCOA."No.") then begin
                                                TargetCOA."Consol. Credit Acc." := SourceCOA."Consol. Credit Acc.";
                                                TargetCOA."Consol. Debit Acc." := SourceCOA."Consol. Debit Acc.";
                                                TargetCOA.Name := SourceCOA.Name;
                                                TargetCOA."Direct Posting" := SourceCOA."Direct Posting";
                                                TargetCOA."Account Type" := SourceCOA."Account Type";
                                                TargetCOA."Account Category" := SourceCOA."Account Category";
                                                TargetCOA.Modify();
                                            end;

                                        end
                                until SourceCOA.Next = 0;
                        until repcompany.Next = 0;
                end;
            }
            action(Delete)
            {
                ApplicationArea = all;
                Image = Delete;
                trigger OnAction()
                var
                    Repcompany: Record Replication;
                    SourceCOA: Record "G/L Account";
                    TargetCOA: Record "G/L Account";
                begin
                    if repcompany.FindSet() then
                        repeat
                            if SourceCOA.FindFirst() then
                                repeat
                                    TargetCOA.Reset();
                                    TargetCOA.ChangeCompany(repcompany."To Company");
                                    if TargetCOA.FindSet() then
                                        repeat
                                            if not SourceCOA.Get(TargetCOA."No.") then begin
                                                if Repcompany.Enable = true then
                                                    TargetCOA.CalcFields(TargetCOA.Balance);
                                                if TargetCOA.Balance = 0 then
                                                    TargetCOA.Delete(true);
                                            end;
                                        until TargetCOA.Next = 0;
                                until SourceCOA.Next = 0;
                        until repcompany.Next = 0;
                end;
            }
        }
    }
}